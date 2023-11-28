import React from "react";
import AdminIndex from "./components/adminScreens/AdminIndex";
import 'bootstrap/dist/css/bootstrap.min.css';
import '@fortawesome/fontawesome-free/css/all.min.css';
// import HomeIndex from "./components/mainScreens/HomeIndex";
import './resources/css/sha.css';
import Login from "./components/mainScreens/Login";
import Home from "./components/mainScreens/Home";
import Footer from './components/mainScreens/Footer';

function App() {
  return (
    <div>
      {/*<AdminIndex/>*/}
      {/* <HomeIndex/> */}
      <Login/>
    </div>
  );
}

export default App;
