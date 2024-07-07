from fastapi import FastAPI, UploadFile, HTTPException, File, APIRouter
from fastapi import  Depends, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.templating import Jinja2Templates
from fastapi import BackgroundTasks
from fastapi.responses import JSONResponse, StreamingResponse, FileResponse
from fastapi.staticfiles import StaticFiles
from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.security import HTTPBasic, HTTPBasicCredentials
from fastapi import APIRouter, Depends, HTTPException
from fastapi.responses import FileResponse

from typing import List
from pathlib import Path
from pydantic import BaseModel

import os
import cv2
from src.face_recognizer import Recognizer
from src.utils import *
import config
from config import recognition_interval_seconds, log_interval_seconds, saveth, save_unknowon
from ultralytics import YOLO
from datetime import datetime

from persiantools.jdatetime import JalaliDate
import MySQLdb
import shutil

import mysql.connector
from mysql.connector import Error

from typing import List





app = FastAPI()


# Database connection parameters
DATABASE_URL = "mysql+mysqlconnector://face:12345@localhost/face_recognition_attendance"


app.mount("/static", StaticFiles(directory="unknown_faces"), name="static")
app.mount("/unknown_images", StaticFiles(directory="unknown_faces"), name="unknown_images")

router = APIRouter()

class User(BaseModel):
    username: str
    section: str

class UnknownImagesResponse(BaseModel):
    images: List[str]

class ImageName(BaseModel):
    imageName: str

# Enable CORS (Cross-Origin Resource Sharing) for all routes
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize face recognizer and YOLO model
recognizer = Recognizer(model_name=config.model_name)
model_track = YOLO('yolov8n.pt')


# Global variable for background tasks
background_tasks = BackgroundTasks()

# Set directories for face bank and unknown faces
face_bank_dir = "face_bank"
unknown_faces_dir = "unknown_faces"



global start_time
global start_time_log
global track_results
global cap 


start_time = int(time.time())
start_time_log = int(time.time())
last_log_time = time.time() 
track_results = {}
log_list = []


stopp = True



mainsql = MySQLdb.connect(host="localhost",    # your host, usually localhost
                     user="face",         # your username
                     passwd="12345",      # your password
                     db="face_recognition_attendance",
                     connect_timeout=30)


cur = mainsql.cursor()

host="localhost"
user="face"
passwd="12345"
database="face_recognition_attendance"




templates = Jinja2Templates(directory="templates")
security = HTTPBasic()


def get_db_connection():
    connection = None
    try:
        connection = mysql.connector.connect(
            host=host,
            user=user,
            password=passwd,
            database=database,
            connect_timeout=30
        )
    except Error as e:
        print(f"The error '{e}' occurred")
    return connection

def augment_image(image):
    # Perform image augmentation operations (e.g., rotation, mirroring)
    # Example: Rotate image by 90 degrees
    augmented_image = cv2.rotate(image, cv2.ROTATE_90_CLOCKWISE)
    return augmented_image


def convert_to_solar_hijri(ad_date):
    ad_datetime = datetime.strptime(ad_date, '%Y-%m-%d')
    solar_hijri_date = JalaliDate.to_jalali(ad_datetime.year, ad_datetime.month, ad_datetime.day)
    return solar_hijri_date.strftime('%Y-%m-%d')

def authenticate_user(credentials: HTTPBasicCredentials = Depends(HTTPBasic())):
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute("SELECT section_name FROM sections WHERE username = %s AND password = %s", (credentials.username, credentials.password))
    section_info = cursor.fetchone()
    cursor.close()
    connection.close()

    if section_info:
        return section_info['section_name']
    else:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Basic"},
        )
def authenticate_userrole(credentials: HTTPBasicCredentials = Depends(HTTPBasic())):
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute("SELECT role FROM staff WHERE staff_id = %s AND national_id = %s", (credentials.username, credentials.password))
    user_info = cursor.fetchone()
    cursor.close()
    connection.close()

    if user_info:
        return user_info['role']
    else:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Basic"},
        )

def unified_streaming_logic(live_mode: bool = False):
    global cap # Or however you initialize your camera

    cap = cv2.VideoCapture('rtsp://admin:army1234@194.168.1.195/1') #OR For CCTV IP Camera is :('rtsp://admin:Army@1234@192.168.1.64/1')
    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break

        if live_mode:
            result_frame2= recognize_faces(frame)
            # Place the Live() processing logic here
            targets, names = load_face_bank()
            frame_rgb_sh = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            result_sh = recognizer.recognize(frame_rgb_sh, targets)


            if len(result_sh) == 3:
                results_sh, bboxes_sh, min_val_sh = result_sh
            else:
                results_sh, bboxes_sh = result_sh
                min_val_sh = None  
            for idx_sh, bbox_sh in enumerate(bboxes_sh):
                if results_sh[idx_sh] != -1:
                    name_sh = names[results_sh[idx_sh]]
                    namesp = name_sh.split()
                    name_sh = namesp[2]
                else:
                    name_sh = 'Unknown'
            
                frame = draw_box_name(frame, bbox_sh.astype("int"), name_sh)

            _, buffer = cv2.imencode('.jpg', frame)
            frame_bytes = buffer.tobytes()

            yield (b'--frame\r\n'
                b'Content-Type: image/jpeg\r\n\r\n' + frame_bytes + b'\r\n')
        
        else:
            # Place the Run() processing logic here
            result_frame2= recognize_faces(frame)



    cap.release()


#RUN and STOP function 
    
def stp():
    global stopp
    if stopp:
        cap.release()



#Face Recognition function 
def recognize_faces(frame):
    
    global track_results, start_time, last_log_time, start_time_log, log_list
    elapsed_time = int(time.time()) - start_time
    elapsed_time_log = int(time.time()) - start_time_log

    print ("TIME IS", elapsed_time_log )
    print(f"Log LIST IS: {log_list}")

    frame1 = frame.copy()

    results_trc = model_track.track(frame, persist=True, conf=0.3, iou=0.5, classes=0, show=False)

    for r in results_trc:
        targets, names = load_face_bank()
        boxes = r.boxes.cpu().numpy()
        xyxy = boxes.xyxy
        ids = boxes.id

        if xyxy is not None and ids is not None:
            for box, box_id in zip(xyxy, ids):
                x1, y1, x2, y2 = box
                id = box_id
                frame1 = frame[int(y1):int(y2), int(x1):int(x2)]
                frame_rgb = cv2.cvtColor(frame1, cv2.COLOR_BGR2RGB)
                result = recognizer.recognize(frame_rgb, targets)

                if len(result) == 3:
                    results, bboxes, min_val = result
                else:
                    results, bboxes = result
                    min_val = None

                if len(results) == 1 and results[0] != -1:
                    name = names[results[0]]
                    track_results.setdefault(id, []).append(name)
                else:
                    name = 'Unknown'
                    track_results.setdefault(id, []).append(name)

                for idx, bbox in enumerate(bboxes):
                    # frame1 = draw_box_name(frame1, bbox.astype("int"), name)

                    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

                    if name != 'Unknown':
                        person_folder = os.path.join(face_bank_dir, name)
                        os.makedirs(person_folder, exist_ok=True)

                        bbox = bbox.astype(int)
                        face_image = frame1[(bbox[1]-int((bbox[1]*0.35))):(bbox[3]+int((bbox[3]*0.35))),
                                            (bbox[0]-int((bbox[0]*0.35))):(bbox[2]+int((bbox[2]*0.35)))]

                        for val in min_val:
                            if val < saveth:
                                save_path = os.path.join(person_folder, f"{name}_{timestamp}.jpg")
                                cv2.imwrite(save_path, face_image)
                    else:
                        bbox = bbox.astype(int)

                        unknown_face_image = frame1[(bbox[1]-int((bbox[1]*0.35))):(bbox[3]+int((bbox[3]*0.35))),
                                                    (bbox[0]-int((bbox[0]*0.35))):(bbox[2]+int((bbox[2]*0.35)))]
                        
                        for val in min_val:
                            if val > save_unknowon:
                                save_path = os.path.join(unknown_faces_dir, f"unknown_{timestamp}.jpg")
                                try:
                                    cv2.imwrite(save_path, unknown_face_image)
                                except cv2.error as e:
                                    print(f"Warning: An error occurred during cv2.imwrite: {e}")

            try:

               
                if elapsed_time >= recognition_interval_seconds:
                    for id, names_list in track_results.items():
                        most_common_name = max(set(names_list), key=names_list.count)
                        # print(f"Track ID {id}: Most recognized name: {most_common_name}")

                        if most_common_name != 'Unknown':
                            # log_list = list(set(log_list)) 
                            log_list.append(most_common_name)  # Append most_common_name to log_list
                        # print(f"Log LIST IS: {log_list}")

                    track_results = {}
                    start_time = time.time()



            except MySQLdb.OperationalError as e:
                print(f"Error occurred while inserting logs: {e}")
                # Continue execution even if there's an error
    if elapsed_time_log >= log_interval_seconds:
        log_list = set(log_list)  # Remove duplicates
        solar_hijri_time = convert_to_solar_hijri(datetime.now().strftime('%Y-%m-%d'))
        # Time2 = f"{datetime.now().strftime('%H:%M:%S')} {solar_hijri_time}"
        Time2 = f"{datetime.now().strftime('%H:%M:%S')}"
        Date =  f"{solar_hijri_time}"
        DT= f"{Date} {Time2}"
        for name in log_list:
            # print(f"Logging: {name}")
            name_parts = name.split()
            personnel_code = name_parts[0]
            cur.execute("INSERT INTO time_log (staff_id, log_time, log_type, gate) VALUES (%s, %s, %s, %s)", (personnel_code, DT, 'exit', 'Gate 2'))
            mainsql.commit()
        log_list = []  # Clear log_list
        start_time_log = time.time()  # Reset start_time_log

    return frame1



app = FastAPI()

origins = ["http://localhost:3000"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
             
async def save_images_to_folder(staffFolderName: str, images: list[UploadFile]) -> None:
    if not os.path.exists(staffFolderName):
        os.makedirs(staffFolderName)
    for image in images:
        with open(os.path.join(staffFolderName, image.filename), "wb") as f:
            content = await image.read()
            f.write(content)
              
              
# Endpoint to manually update the face bank
@app.get("/overWrite_face_bank")
async def overwrite_face_bank_using_post():
    global targets, names
    targets, names = overwrite_face_bank(recognizer)
    return JSONResponse(content={"message": "Face bank updated successfully"}, status_code=200)


# @app.post("/update_face_bank")
@app.get("/update_face_bank")
async def update_face_bank_using_post():
    global targets, names
    targets, names = update_face_bank(recognizer)
    return JSONResponse(content={"message": "Face bank updated successfully"}, status_code=200)


@app.get("/stream")
async def stream():
    global stopp, cap
    stopp = False

    return StreamingResponse(content=unified_streaming_logic(live_mode=False),
                             media_type="multipart/x-mixed-replace;boundary=frame")

@app.get("/livestream")
async def livestream():
    global stopp, cap
    stopp = False
    return StreamingResponse(content=unified_streaming_logic(live_mode=True),
                             media_type="multipart/x-mixed-replace;boundary=frame")


@app.get("/stop_stream")
async def stpstream():
    global stopp
    stopp = True
    return StreamingResponse(
        content=stp()
    )

@app.get("/status")
async def get_system_status():
    global stopp
    if not stopp :
        return {"status": "running"}
    else:
        return {"status": "stopped"}
    

#############
@app.get("/get_unknown_images")
async def get_unknown_images():
    try:
        # List all files in the directory
        directory = "unknown_faces"
        files = [file for file in os.listdir(directory) if file.lower().endswith(('.png', '.jpg', '.jpeg'))]
        return {"images": files}
    except Exception as e:
        print(f"Error: {str(e)}")
        raise HTTPException(status_code=500, detail="Internal Server Error")

# Background task to log results within specified time interval

@app.get("/unknown_images/{image_name}")
async def get_unknown_image(image_name: str):
    try:
        # Serve individual images
        image_path = f"unknown_faces/{image_name}"
        return FileResponse(image_path, media_type="image/jpeg")
    except Exception as e:
        print(f"Error: {str(e)}")
        raise HTTPException(status_code=500, detail="Internal Server Error")
    
# Endpoint to get a list of unknown images
@app.get("/get_unknown_images", response_model=UnknownImagesResponse)
def get_unknown_images():
    images = os.listdir("unknown_faces")
    return {"images": images}


# Endpoint to delete a single unknown image
@app.post("/delete_unknown_image")
async def delete_unknown_image(image_data: ImageName):
    image_name = image_data.imageName  # Extracting imageName from the request body
    image_path = os.path.join(unknown_faces_dir, image_name)
    try:
        if os.path.exists(image_path):
            os.remove(image_path)
            return JSONResponse(status_code=status.HTTP_200_OK, content={"message": "Image deleted successfully"})
        else:
            return HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Image not found")
    except Exception as e:
        return HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=f"An error occurred: {e}")
    
@app.post("/delete_selected_unknown_images")
async def delete_selected_unknown_images(images: list[str]):
    for image_name in images:
        image_path = os.path.join(unknown_faces_dir, image_name)
        try:
            if os.path.exists(image_path):
                os.remove(image_path)
            else:
                raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Image not found")
        except Exception as e:
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=f"An error occurred: {e}")

    return {"message": "Selected unknown images deleted successfully"}
# Endpoint to delete all unknown images
@app.post("/delete_all_unknown_images")
async def delete_all_unknown_images():
    folder_path = "unknown_faces"
    for file_name in os.listdir(folder_path):
        file_path = os.path.join(folder_path, file_name)
        try:
            if os.path.isfile(file_path):
                os.unlink(file_path)
            elif os.path.isdir(file_path):
                shutil.rmtree(file_path)
        except Exception as e:
            print(f"Error deleting {file_path}: {e}")

    return {"message": "All unknown images deleted successfully"}


@app.post("/move_selected_unknown_images")
async def move_selected_unknown_images(data: dict):
    folder_name = data.get("folder_name")
    images = data.get("images")
    if not folder_name or not images:
        raise HTTPException(status_code=status.HTTP_422_UNPROCESSABLE_ENTITY, detail="Folder name or images not provided")
    
    folder_path = os.path.join(face_bank_dir, folder_name)  # Update with your directory path
    try:
        if not os.path.exists(folder_path):
            os.makedirs(folder_path)
        for image in images:
            source_path = os.path.join(unknown_faces_dir, image)  # Update with your directory path
            destination_path = os.path.join(folder_path, image)
            os.rename(source_path, destination_path)
        return {"message": "Selected images moved successfully"}
    except Exception as e:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=f"An error occurred: {e}")


    
@app.post("/create_staff_folder")
async def create_staff_folder(staff_prof: dict):
    try:
        # Check if all fields are provided
        # Check if all fields are provided
        if not staff_prof['PersonnelCode'] or not staff_prof['NationalID'] or not staff_prof['FirstName'] or not staff_prof['LastName'] or not staff_prof['Section'] or not staff_prof['Role']:
            raise HTTPException(status_code=400, detail='Please provide all the staff information.')

        # Create folder name
        folder_name = f"{staff_prof['PersonnelCode']} {staff_prof['NationalID']} {staff_prof['FirstName']} {staff_prof['LastName']} {staff_prof['Section']}"
        pc, ni, fn, ln, sec, role = {staff_prof['PersonnelCode']}, {staff_prof['NationalID']}, {staff_prof['FirstName']}, {staff_prof['LastName']}, {staff_prof['Section']}, {staff_prof['Role']}


        # Specify the path to the face_bank directory
        face_bank_path = face_bank_dir 

        # Create the staff folder
        folder_path = os.path.join(face_bank_path, folder_name)
        os.makedirs(folder_path, exist_ok=True)

        conn =  MySQLdb.connect(
        host="localhost",   
        user="face",        
        passwd="12345", 
        db="face_recognition_attendance",
        )

        cursor = conn.cursor()

        # Fetch log table data
        cursor.execute("INSERT INTO staff VALUES (%s, %s, %s, %s, %s, %s)", (pc, ni, fn, ln, sec, role))
        conn.commit()

        # Close MySQL connection
        cursor.close()
        conn.close()



        return JSONResponse(content={"message": "Staff folder created successfully."}, status_code=200)
    except Exception as e:
        return JSONResponse(content={"message": f"Error creating staff folder: {str(e)}"}, status_code=500)



@app.post("/save_images_to_folder/{staff_folder_name}")
# async def save_images_to_folder(staff_folder_name: str, images: UploadFile = File(...)):
async def save_images_to_folder(staff_folder_name: str, file_uploads: list[UploadFile]):

    face_bank_path = face_bank_dir
    folder_path = os.path.join(face_bank_path, staff_folder_name)
    folder_path = Path() / folder_path
    for file_upload in file_uploads:
        data = await file_upload.read()
        save_to = folder_path / file_upload.filename
        with open(save_to, 'wb') as f:
            f.write(data)

    return{"filenames": [f.filename for f in file_uploads]}

@app.post("/augment_images")
async def augment_images(files: List[UploadFile] = File(...)):
    augmented_files = []
    for file in files:
        # Read image file
        contents = await file.read()
        nparr = np.frombuffer(contents, np.uint8)
        image = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

        # Augment image
        augmented_image = augment_image(image)

        # Save augmented image to specified folder
        filename = os.path.join("//home/rezaazg/Reza/Face/Face-Recognition/AugmentedImages", f"augmented_{file.filename}")
        cv2.imwrite(filename, augmented_image)

        # Append filename to list
        augmented_files.append(filename)

    return augmented_files

@app.get("/get_augmented_images")
async def get_augmented_images():
    try:
        # Get the list of files in the augmented images directory
        augmented_images = os.listdir("//home/rezaazg/Reza/Face/Face-Recognition/AugmentedImages")
        # Return the list of augmented images
        return JSONResponse(content=augmented_images)
    except Exception as e:
        return JSONResponse(content={"error": str(e)}, status_code=500)

@app.get("/display_staff_names")
async def display_staff_names():
    try:
        existing_embeddings, existing_names = get_face_bank()
        return {"names": existing_names}
    except Exception as e:
        return JSONResponse(content={"message": f"Error retrieving staff names: {str(e)}"}, status_code=500)
    
@app.post("/delete_selected_staff_names/{name}")
async def delete_selected_staff_names(name: str):
    # global targets, names
    # targets, names = load_face_bank()
    return delete_staff_names(name)

@app.get("/get_folder_names")
async def get_folder_names():
    folder_path = face_bank_dir # Update with your directory path
    try:
        folder_names = [folder for folder in os.listdir(folder_path) if os.path.isdir(os.path.join(folder_path, folder))]
        return {"folder_names": folder_names}
    except Exception as e:
        return HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=f"An error occurred: {e}")


@app.delete("/delete_logs/{date}")
async def delete_logs(date: str):
    connection = get_db_connection()
    if not connection:
        return {"error": "Database connection failed"}

    try:
        cursor = connection.cursor()
        cursor.execute("DELETE FROM Staff WHERE Date = %s", (date,))
        connection.commit()
        return {"message": f"Deleted logs for date: {date}"}
    except Exception as e:
        return {"error": str(e)}
    finally:
        cursor.close()
        connection.close()

@app.get("/attendance_logs/")
async def get_attendance_logs(staff_id: int, national_id: str, start_date: str, end_date: str):
    query = """
    SELECT *
    FROM staff_attendance_view
    WHERE staff_id = %s AND national_id = %s AND date BETWEEN %s AND %s;
    """
    connection = get_db_connection()
    if not connection:
        raise HTTPException(status_code=500, detail="Database connection error")
    cursor = connection.cursor(dictionary=True)
    cursor.execute(query, (staff_id, national_id, start_date, end_date))
    logs = cursor.fetchall()
    cursor.close()
    connection.close()
    return logs

@app.get("/login_check")
def login_check(section_name: str = Depends(authenticate_user)):

    # If the section_name is returned by authenticate_user dependency, it means authentication was successful.
    return {"message": f"Credentials are valid for section: {section_name}"}

@app.get("/login_check2")
def login_check(role: str = Depends(authenticate_userrole)):

    # If the section_name is returned by authenticate_user dependency, it means authentication was successful.
    return {"message": f"Credentials are valid for section: {role}"}


@app.get("/attendance_logs_section_res/")
async def get_section_attendance_logs(start_date: str, end_date: str):
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    # Assume the section name is hardcoded as 'پژوهش'
    query = "SELECT * FROM staff_attendance_view_پژوهش WHERE date BETWEEN %s AND %s"
    cursor.execute(query, (start_date, end_date))
    logs = cursor.fetchall()
    cursor.close()
    connection.close()
    return logs

@app.get("/attendance_logs_section_fin/")
async def get_section_attendance_logs(start_date: str, end_date: str):
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    # Assume the section name is hardcoded as 'پژوهش'
    query = "SELECT * FROM staff_attendance_view_مالی WHERE date BETWEEN %s AND %s"
    cursor.execute(query, (start_date, end_date))
    logs = cursor.fetchall()
    cursor.close()
    connection.close()
    return logs

@app.get("/attendance_logs_section_official/")
async def get_section_attendance_logs(start_date: str, end_date: str):
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    # Assume the section name is hardcoded as 'پژوهش'
    query = "SELECT * FROM staff_attendance_view_اداری WHERE date BETWEEN %s AND %s"
    cursor.execute(query, (start_date, end_date))
    logs = cursor.fetchall()
    cursor.close()
    connection.close()
    return logs

@app.get("/attendance_logs_section_it/")
async def get_section_attendance_logs(start_date: str, end_date: str):
    connection = get_db_connection()
    cursor = connection.cursor(dictionary=True)
    # Assume the section name is hardcoded as 'پژوهش'
    query = "SELECT * FROM staff_attendance_view_IT WHERE date BETWEEN %s AND %s"
    cursor.execute(query, (start_date, end_date))
    logs = cursor.fetchall()
    cursor.close()
    connection.close()
    return logs






if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
