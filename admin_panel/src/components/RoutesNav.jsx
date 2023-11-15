import React from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Navbar from "./Navbar";
import Home from "./Home";
import Login from "./Login";
import NoContent from "./NoContent";

export default function RoutesNav() {
  return (
    <>
      <Navbar />
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<Home />}></Route>
          {/* <Route index element={<Home />} /> */}
          <Route path="home" element={<Home />} />
          <Route path="login" element={<Login />} />
          <Route path="*" element={<NoContent />} />
        </Routes>
      </BrowserRouter>
    </>
  );
}
