import React, { useEffect, useRef } from "react";
import "datatables.net-dt/css/jquery.dataTables.css"; // Import DataTables CSS
import $ from "jquery";
import "popper.js";
import DataTable from "datatables.net-dt";
import { Doughnut } from 'react-chartjs-2';

let table = new DataTable("#myTable");

const TableAdmin = () => {
  const tableRef = useRef();

  useEffect(() => {
    $(tableRef.current).DataTable();

    
  }, []);



  return (
    <div id="main">
      <div class="container-fluid px-4">
        <table ref={tableRef} className="display">
          <thead>
            <tr>
              <th>Name</th>
              <th>Email</th>
            </tr>
          </thead>
          <tfoot>
            <tr>
              <th>Name</th>
              <th>Email</th>
            </tr>
          </tfoot>
          <tbody>
            <tr>
              <td>John Doe</td>
              <td>john@example.com</td>
            </tr>
            <tr>
              <td>Nasik</td>
              <td>nasik@example.com</td>
            </tr>
            <tr>
              <td>Madhuni</td>
              <td>madhuni@example.com</td>
            </tr>
            <tr>
              <td>Ishani</td>
              <td>ishani@example.com</td>
            </tr>
            <tr>
              <td>Madhuni</td>
              <td>madhuni@example.com</td>
            </tr>
            <tr>
              <td>Ishani</td>
              <td>ishani@example.com</td>
            </tr>
            <tr>
              <td>Madhuni</td>
              <td>madhuni@example.com</td>
            </tr>
            <tr>
              <td>Ishani</td>
              <td>ishani@example.com</td>
            </tr>
            <tr>
              <td>Madhuni</td>
              <td>madhuni@example.com</td>
            </tr>
            <tr>
              <td>Ishani</td>
              <td>ishani@example.com</td>
            </tr>
            <tr>
              <td>Madhuni</td>
              <td>madhuni@example.com</td>
            </tr>
            <tr>
              <td>Ishani</td>
              <td>ishani@example.com</td>
            </tr>
            <tr>
              <td>Madhuni</td>
              <td>madhuni@example.com</td>
            </tr>
            <tr>
              <td>Ishani</td>
              <td>ishani@example.com</td>
            </tr>
            <tr>
              <td>Madhuni</td>
              <td>madhuni@example.com</td>
            </tr>
            <tr>
              <td>Ishani</td>
              <td>ishani@example.com</td>
            </tr>
            <tr>
              <td>Madhuni</td>
              <td>madhuni@example.com</td>
            </tr>
            <tr>
              <td>Ishani</td>
              <td>ishani@example.com</td>
            </tr>
            <tr>
              <td>Madhuni</td>
              <td>madhuni@example.com</td>
            </tr>
            <tr>
              <td>Ishani</td>
              <td>ishani@example.com</td>
            </tr>
            <tr>
              <td>Madhuni</td>
              <td>madhuni@example.com</td>
            </tr>
            <tr>
              <td>Ishani</td>
              <td>ishani@example.com</td>
            </tr>
            <tr>
              <td>Madhuni</td>
              <td>madhuni@example.com</td>
            </tr>
            <tr>
              <td>Ishani</td>
              <td>ishani@example.com</td>
            </tr>
            <tr>
              <td>Madhuni</td>
              <td>madhuni@example.com</td>
            </tr>
            <tr>
              <td>Ishani</td>
              <td>ishani@example.com</td>
            </tr>
          </tbody>
        </table>
      </div>

      <div className="row">
        <div className="container m-2">
        <div class="col-lg-6 col-md-6">
          <div class="container-fluid card mb-4">
            <div class="card-header">
              <i class="fas fa-chart-pie me-1"></i>
              Pie Chart Example
            </div>
            <div class="card-body">
              <canvas id="myPieChart" width="100%" height="50"></canvas>
            </div>
            <div class="card-footer small text-muted">
              Updated yesterday at 11:59 PM
            </div>
          </div>
        </div>
        </div>
      </div>
    </div>
  );
};

export default TableAdmin;
