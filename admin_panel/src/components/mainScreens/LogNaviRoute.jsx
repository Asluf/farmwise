import React from "react";
import Home from "./Home";
import NoContent from "../adminScreens/NoContent";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Login from "./Login";

export default function LogNaviRoute() {
  return (
    <>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/home" element={<Home />} />
          <Route path="/login" element={<Login />} />
          <Route path="*" element={<NoContent />} />
        </Routes>
      </BrowserRouter>
    </>
  );
}
