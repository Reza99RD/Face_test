import React, { useContext, useState, useEffect } from 'react';
import { Navbar, Nav, Form, Button } from 'react-bootstrap';
import { Link } from 'react-router-dom';
import LiveStream from './LiveStream';
import axios from 'axios';
import jalaali from 'jalaali-js';

const NavBar = () => {
  const [isLiveStreamVisible, setIsLiveStreamVisible] = useState(false);
  const [systemStatus, setSystemStatus] = useState('System is Stopped');
  const [currentTime, setCurrentTime] = useState('');

  useEffect(() => {
    const fetchSystemStatus = async () => {
      try {
        // Make concurrent requests to both endpoints
        const [response8000, response7000] = await Promise.all([
          axios.get('http://localhost:8000/status'),
          axios.get('http://localhost:7000/status')
        ]);
    
        // Check the status of both responses
        const isRunning8000 = response8000.data.status === 'running';
        const isRunning7000 = response7000.data.status === 'running';
    
        // Determine the combined status
        if (isRunning8000 && isRunning7000) {
          setSystemStatus('برنامه در حال اجرا شدن می باشد');
        } else if (!isRunning8000 && !isRunning7000) {
          setSystemStatus('برنامه در وضعیت توقف می باشد');
        } else {
          setSystemStatus('برنامه در حال اجرا شدن می باشد');
        }
    
      } catch (error) {
        console.error('Error fetching system status:', error);
        setSystemStatus('خطا در دریافت وضعیت سیستم');
      }
    };
    

    // Fetch initial system status
    fetchSystemStatus();

    // Fetch system status periodically
    const statusInterval = setInterval(fetchSystemStatus, 1000);



   // Function to update time every second
    const updateTime = () => {
      const now = new Date();
      const jalaaliDate = jalaali.toJalaali(now);
      setCurrentTime(`${jalaaliDate.jy}/${jalaaliDate.jm}/${jalaaliDate.jd} ${now.getHours()}:${now.getMinutes()}:${now.getSeconds()}`);
    };

    const timeInterval = setInterval(updateTime, 1000);

    // Initial time update
    updateTime();

    return () => {
      clearInterval(statusInterval);
      clearInterval(timeInterval);
    };
  }, []);

  const startStream = async () => {
    try {
      // Create an array of promises for the axios GET requests
      const promises = [
        axios.get('http://localhost:8000/stream'),
        axios.get('http://localhost:7000/stream')
      ];
  
      // Use Promise.all to wait for all promises to resolve
      const responses = await Promise.all(promises);
  
      // Log success messages for both streams
      console.log('Live stream started from backend on port 8000.');
      console.log('Live stream started from backend on port 7000.');
    } catch (error) {
      // If any request fails, this block catches the error
      console.error('Error starting live stream:', error);
    }
  };
  
  const stopStream = async () => {
    try {
      // Create an array of promises for the axios GET requests
      const promises = [
        axios.get('http://localhost:8000/stop_stream'),
        axios.get('http://localhost:7000/stop_stream')
      ];
  
      // Use Promise.all to wait for all promises to resolve
      const responses = await Promise.all(promises);
  
      // Log success messages for both streams
      console.log('Live stream stoped from backend on port 8000.');
      console.log('Live stream stoped from backend on port 7000.');
    } catch (error) {
      // If any request fails, this block catches the error
      console.error('Error stoped live stream:', error);
    }
  };


  const handleHomeClick = () => {
    // Close all windows and go to the initial page
    window.location.href = '/';
  };

  const buttonStyles = {
    width: '200px',
    fontSize: '18px',
    margin: '5px',
  };

  const buttonColors = [
    'success',
    'danger',
    'primary',
    'info',
    'warning',
    'secondary',
  ];

  return (
    <div style={{ textAlign: 'center', backgroundColor: '#282c34', color: 'white' }}>
      <h1 style={{ fontSize: '3em', fontFamily: 'cursive', padding: '20px' }} onClick={handleHomeClick}>
        سیستم اتوماسیون تردد مبتنی بر شناسایی چهره
      </h1>
      <div style={{ fontWeight: 'bold', fontSize: '1.85em' }}> {/* Updated font size here */}
      {currentTime}
      </div>
      <div style={{ fontWeight: 'bold', fontSize: '1.5em', color: systemStatus === 'برنامه در حال اجرا شدن می باشد' ? 'white' : 'red', backgroundColor: systemStatus === 'برنامه در حال اجرا شدن می باشد' ? 'green' : 'white', padding: '10px', borderRadius: '5px' }}>
        {systemStatus}
      </div>
      <Navbar bg="dark" expand="lg" variant="dark">
        <Navbar.Toggle aria-controls="basic-navbar-nav" />
        <Navbar.Collapse id="basic-navbar-nav" className="d-flex justify-content-center">
          <Nav className="mr-auto">
            {/* <Badge className="mt-2" variant="primary">Staff{staff.data.length}</Badge> */}
          </Nav>
          <Form inline>
            <div className="d-flex justify-content-center"> 
            <Button variant={buttonColors[0]} size="lm" style={buttonStyles} onClick={startStream}>
              شروع
            </Button>
            <Button variant={buttonColors[1]} size="lm" style={buttonStyles} onClick={stopStream}>
              توقف
            </Button>
            </div>
            {/* <Link to="/stafftable" className={`btn btn-${buttonColors[2]} btn-sm mr-2`} style={buttonStyles}>
              Logs Table
            </Link> */}
            <Link to="/attendancelogsviewer" className={`btn btn-${buttonColors[2]} btn-sm mr-2`} style={buttonStyles}>
              نمایش حضور و غیاب
            </Link>
            {/* <Link to="/addstaff" className={`btn btn-${buttonColors[3]} btn-sm mr-2`} style={buttonStyles}>
              Add Staff
            </Link> */}
            {/* <Link to="/staffnames" className={`btn btn-${buttonColors[4]} btn-sm mr-2`} style={buttonStyles}>
              Display Staff Names
            </Link> */}
            {/* <Link to="/unknownfaces" className={`btn btn-${buttonColors[5]} btn-sm mr-2`} style={buttonStyles}>
              Unknown Faces
            </Link> */}
            {/* <Button variant="info" size="sm" className="mr-2" style={buttonStyles} onClick={updateFacebank}>
              Update FaceBank
            </Button>
            <Button variant="warning" size="sm" className="mr-2" style={buttonStyles} onClick={overWritefacebank}>
              Overwrite FaceBank
            </Button> */}
            {/* <Link to="/setting" className={`btn btn-${buttonColors[5]} btn-sm mr-2`} style={buttonStyles}>
              Setting
            </Link> */}
            {/* <Button variant={buttonColors[2]} size="lm" className="mr-2" style={buttonStyles} onClick={liveStream}>
                Live Stream
            </Button> */}
            {/* <Link to="/livestram" className={`btn btn-${buttonColors[2]} btn-sm mr-2`} style={buttonStyles}>
              Show Live Stream
            </Link> */}
            {/* <Link to="/attendancelogsit" className={`btn btn-${buttonColors[2]} btn-sm mr-2`} style={buttonStyles}>
              حضور و غیاب بخش ها
            </Link> */}
            {/* <Button variant="secondary" size="sm" style={buttonStyles} onClick={hideLiveStream}>
              Hide Live Stream
            </Button> */}
            {isLiveStreamVisible && <LiveStream />} {/* Use the LiveStream component */}
          </Form>
        </Navbar.Collapse>
      </Navbar>
    </div>
  );
};

export default NavBar;
