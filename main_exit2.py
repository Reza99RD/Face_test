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





app = FastAPI(title="Face Recognition Based Attendance System", description="This app is designed for an attendance system based on facial recognition.")


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

    cap = cv2.VideoCapture('rtsp://admin:Army@1234@194.168.1.195/1')
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
            cur.execute("INSERT INTO time_log (staff_id, log_time, log_type, gate) VALUES (%s, %s, %s, %s)", (personnel_code, DT, 'enter', 'Gate 1'))
            mainsql.commit()
        log_list = []  # Clear log_list
        start_time_log = time.time()  # Reset start_time_log

    return frame1



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

### ENDPOINTS FOR SYSTEM START AND STOP AND STATUS ####
@app.get("/stream", tags=["System Control"])
async def start_recognition_system():
    global stopp, cap
    stopp = False

    return StreamingResponse(content=unified_streaming_logic(live_mode=False),
                             media_type="multipart/x-mixed-replace;boundary=frame")

@app.get("/stop_stream", tags=["System Control"])
async def stop_recognition_system():
    global stopp
    stopp = True
    return StreamingResponse(
        content=stp()
    )

@app.get("/status", tags=["System Control"])
async def get_system_status():
    global stopp
    if not stopp :
        return {"status": "running"}
    else:
        return {"status": "stopped"}     
    

@app.get("/livestream", tags=["System Control"])
async def livestream_of_CCTV_cameras():
    global stopp, cap
    stopp = False
    return StreamingResponse(content=unified_streaming_logic(live_mode=True),
                             media_type="multipart/x-mixed-replace;boundary=frame")

        
#############################################################################    




if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
