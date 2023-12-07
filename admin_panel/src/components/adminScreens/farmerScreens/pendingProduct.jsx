import React, { useState, useEffect, useRef } from "react";
import "datatables.net-dt/css/jquery.dataTables.css"; // Import DataTables CSS
import $ from "jquery";
import "popper.js";
import DataTable from "datatables.net-dt";
import { useToggleState } from "../ToggleState";
import { Link, Outlet } from "react-router-dom";

let table = new DataTable("#myTable");

export default function PendingProduct() {
  const { isToggled } = useToggleState();

  const tableRef = useRef();

  useEffect(() => {
    $(tableRef.current).DataTable();
  }, []);

  return (
    <div id="main" className={isToggled ? "toggled" : ""}>
      <div className="container-fluid px-4">
        <div className="my-4">
          <h1>Pending Product Details</h1>
        </div>
        <hr className="mb-5" />
        <table ref={tableRef} className="display">
          <thead>
            <tr>
              <th>Crop Name</th>
              <th>x</th>
              <th>y</th>
              <th>y</th>
              <th>z</th>
              <th>c</th>
              <th> </th>
            </tr>
          </thead>
          <tfoot>
            <tr>
              <th>Crop Name</th>
              <th>x</th>
              <th>y</th>
              <th>y</th>
              <th>z</th>
              <th>c</th>
              <th> </th>
            </tr>
          </tfoot>
          <tbody>
            <tr>
              <td>Beetrrot</td>
              <td>56788754456</td>
              <td>PLR5678</td>
              <td>0754323456</td>
              <td>john@example.com</td>
              <td>
                <button className="btn btn-sm btn-success">Approve</button>
              </td>
              <td>
                <Link to="/pendingProductDetails/5">
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
