import React, { useState } from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import NavBar from './components/NavBar';
import { StaffProvider } from './StaffContext';
import LiveStream from './components/LiveStream';
import AddStaff from './components/AddStaff';
import ImageUpload from './components/ImageUpload';
import DisplayNames from './components/DisplayNames';
import UnknownFaces from './components/UnknownFaces';
import LandingPage from './components/LandingPage';
import LiveStreamEntrance  from './components/LiveStreamEntrance';
import LiveStreamExit  from './components/LiveStreamExit';
import AttendanceLogsViewer  from './components/AttendanceLogsViewer';
import AttendanceLogsResarch from './components/AttendanceLogsResarch';
import AttendanceLogsFinance from './components/AttendanceLogsFinance';
import AttendanceLogsIT from './components/AttendanceLogsIT';
import AttendanceLogsOfficial from './components/AttendanceLogsOfficial';
import AdminPage  from './components/AdminPage';
import HR  from './components/HRPage';
import Security  from './components/SecurityPage';

function App() {
  const [userRole, setUserRole] = useState(null); // Define setUserRole function

  return (
    <div>
      <Router>
        <StaffProvider>
          <NavBar />
          <div className="row">
            <div className="col-sm-10 col-xs-12 mr-auto ml-auto mt-4 mb-4">
              <Switch>
                {/* Pass setUserRole as a prop to LandingPage */}
                <Route exact path="/" render={(props) => <LandingPage {...props} setUserRole={setUserRole} />} />
                <Route exact path="/addstaff" component={AddStaff} />
                <Route exact path="/addstaff/imageupload" component={ImageUpload} />
                <Route exact path="/staffnames" component={DisplayNames} />
                <Route exact path="/unknownfaces" component={UnknownFaces} />
                <Route exact path="/livestram" component={LiveStream} />
                <Route exact path="/livestram/entrance" component={LiveStreamEntrance} />
                <Route exact path="/livestram/exit" component={LiveStreamExit} />
                <Route exact path="/attendancelogsviewer" component={AttendanceLogsViewer} />
                <Route exact path="/attendancelogsresarch" component={AttendanceLogsResarch} />
                <Route exact path="/attendancelogsfinance" component={AttendanceLogsFinance} />
                <Route exact path="/attendancelogsit" component={AttendanceLogsIT} />
                <Route exact path="/attendancelogsofficial" component={AttendanceLogsOfficial} />
                <Route exact path="/admin" component={AdminPage} />
                <Route exact path="/hr" component={HR} />
                <Route exact path="/security" component={Security} />
              </Switch>
            </div>
          </div>
        </StaffProvider>
      </Router>
    </div>
  );
}
export default App;
