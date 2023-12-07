import React from "react";
import { BrowserRouter } from "react-router-dom";
import Home from "./Home";
import About from "./About";
import NoContent from "./NoContent";
import { Routes, Route } from "react-router-dom";
import AdminSideBar from "./AdminSideBar";
import TableAdmin from "./TableAdmin";
import FarmerManage from "./farmerScreens/farmerManage";
import FarmerDetails from "./farmerScreens/moreInfo/farmerDetails";
import PendingProduct from "./farmerScreens/pendingProduct";
import PendingProductDetails from "./farmerScreens/moreInfo/pendingProductDetails";

export default function AdminNaviRoute() {
  return (
    <>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<AdminSideBar />}>
            <Route index element={<Home />} />
            <Route path="home" element={<Home />} />
            <Route path="about" element={<About />} />
            <Route path="table" element={<TableAdmin />} />
            <Route path="farmerManage" element={<FarmerManage/>} />
            <Route path="farmerDetails/:id" element={<FarmerDetails/>} />
            <Route path="pendingProduct" element={<PendingProduct/>} />
            <Route path="pendingProductDetails/:id" element={<PendingProductDetails/>} />


            <Route path="*" element={<NoContent />} />
          </Route>
        </Routes>
      </BrowserRouter>
    </>
  );
}
