import React, { useState, useEffect, useRef } from "react";
import "datatables.net-dt/css/jquery.dataTables.css"; // Import DataTables CSS
import $ from "jquery";
import "popper.js";
import DataTable from "datatables.net-dt";
import { useToggleState } from "../ToggleState";
import { Link, Outlet } from "react-router-dom";

let table = new DataTable("#myTable");

export default function FarmerManage() {
  const { isToggled } = useToggleState();

  const tableRef = useRef();
  
  useEffect(() => {
    $(tableRef.current).DataTable();
  }, []);

  return (
    <div id="main" className={isToggled ? "toggled" : ""}>
      <div className="container-fluid px-4">
        <div className="my-4">
          <h1>All Farmer Details</h1>
        </div>
        <hr className="mb-5" />
        <table ref={tableRef} className="display">
          <thead>
            <tr>
              <th>Name</th>
              <th>NIC</th>
              <th>Reg ID</th>
              <th>Contact No</th>
              <th>Email</th>
              <th>Status</th>
              <th> </th>
            </tr>
          </thead>
          <tfoot>
            <tr>
              <th>Name</th>
              <th>NIC</th>
              <th>Reg ID</th>
              <th>Contact No</th>
              <th>Email</th>
              <th>Status</th>
              <th> </th>
            </tr>
          </tfoot>
          <tbody>
            <tr>
              <td>John Doe</td>
              <td>56788754456</td>
              <td>PLR5678</td>
              <td>0754323456</td>
              <td>john@example.com</td>
              <td>
                <button className="btn btn-sm btn-success">Approve</button>
              </td>
              <td>
                <Link to="/farmerDetails/5">
                  <i class="fa fa-info-circle" aria-hidden="true"></i>
                </Link>
              </td>
            </tr>
            <tr>
              <td>David Doe</td>
              <td>56788754456</td>
              <td>PLR5678</td>
              <td>0754323456</td>
              <td>john@example.com</td>
              <td>
                <button className="btn btn-sm btn-warning">Pending</button>
              </td>
              <td>
                <Link to="/farmerDetails/9">
                  <i class="fa fa-info-circle" aria-hidden="true"></i>
                </Link>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      <Outlet />
    </div>
  );
}
