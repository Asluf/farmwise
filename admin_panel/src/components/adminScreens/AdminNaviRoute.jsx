import React from "react";
import { BrowserRouter } from "react-router-dom";
import Home from "./Home";
import About from "./About";
import NoContent from "./NoContent";
import { Routes, Route } from "react-router-dom";
import AdminSideBar from "./AdminSideBar";

export default function AdminNaviRoute() {
  return (
    <>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<AdminSideBar />}>
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
