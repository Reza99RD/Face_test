import React, { useEffect } from 'react';
import { Button } from 'react-bootstrap';
import axios from 'axios';

const LiveStream = () => {
  const buttonStyle2 = {
    width: '350px',
    height: '100px',
    margin: '150px',
    borderRadius: '10px',
    textAlign: 'center',
    color: 'white',
    fontSize: '35px',
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
  };

  const stopStream = async () => {
    try {
      const promises = [
        axios.get('http://localhost:8000/stop_stream'),
        axios.get('http://localhost:7000/stop_stream')
      ];

      const responses = await Promise.all(promises);
      console.log('Live stream stopped from backend on port 8000.');
      console.log('Live stream stopped from backend on port 7000.');
    } catch (error) {
      console.error('Error stopping live stream:', error);
    }
  };

  useEffect(() => {
    stopStream(); // Call stopStream when the component mounts
  }, []); // Empty dependency array ensures this runs once when the component mounts

  const handleNavigation = (url) => {
    window.location.href = url; // Navigate to the specified URL
  };

  return (
    <div style={{ textAlign: 'center', padding: '20px', backgroundColor: '#282c34', color: 'white', minHeight: '100vh', minWidth: '200vh' }}>
      <h1 style={{ fontSize: '4em', fontFamily: 'cursive' }}>نمایش پخش زنده دوربین ها</h1>
      <div style={{ marginBottom: '20px', display: 'flex', flexDirection: 'row', justifyContent: 'center' }}>
        <Button variant="primary" style={buttonStyle2} onClick={() => handleNavigation('/entrancestream')}>
          دوربین ورودی
        </Button>
        <Button variant="primary" style={buttonStyle2} onClick={() => handleNavigation('/exitstream')}>
          دوربین خروجی
        </Button>
      </div>
    </div>
  );
};

export default LiveStream;
