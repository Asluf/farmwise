import React from "react";
import AdminIndex from "./components/adminScreens/AdminIndex";
import 'bootstrap/dist/css/bootstrap.min.css';
import '@fortawesome/fontawesome-free/css/all.min.css';
//import HomeIndex from "./components/mainScreens/HomeIndex";
import './resources/css/sha.css';

function App() {
  return (
    <div>
      <AdminIndex/>
      {/* <HomeIndex/> */}
    </div>
  );
}

export default App;
