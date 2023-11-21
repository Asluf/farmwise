import React from "react";
import { BrowserRouter } from "react-router-dom";
import NavBar from "./AdminNavBar";
import Home from "./Home";
import About from "./About";
import NoContent from "./NoContent";
import { Routes, Route } from "react-router-dom";
import Login from "../mainScreens/Login";

export default function AdminNaviRoute() {
  return (
    <>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<NavBar />}>
            <Route index element={<Home />} />
            <Route path="home" element={<Home />} />
            <Route path="about" element={<About />} />
            <Route path="*" element={<NoContent />} />
          </Route>
        </Routes>
      </BrowserRouter>
    </>
  );
}
