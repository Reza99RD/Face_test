import React from 'react';
import { Button } from 'react-bootstrap';

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

 return (
     <div style={{ textAlign: 'center', padding: '20px', backgroundColor: '#282c34', color: 'white', minHeight: '100vh', minWidth: '200vh' }}>
       <h1 style={{ fontSize: '4em', fontFamily: 'cursive' }}>نمایش پخش زنده دوربین ها</h1>
        <div style={{ marginBottom: '20px', display: 'flex', flexDirection: 'row', justifyContent: 'center' }}>
           <Button variant="primary" style={buttonStyle2} onClick={() => window.location.href = '/livestram/entrance'}>
             دوربین ورودی
           </Button>
           <Button variant="primary" style={buttonStyle2} onClick={() => window.location.href = '/livestram/exit'}>
             دوربین خروجی
           </Button>
        </div>
     </div>      
 );
};

export default LiveStream;
