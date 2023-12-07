import React, { useState, useEffect, useRef } from "react";
import "datatables.net-dt/css/jquery.dataTables.css"; // Import DataTables CSS
import $ from "jquery";
import "popper.js";
import DataTable from "datatables.net-dt";
import { Doughnut } from "react-chartjs-2";
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from "chart.js";
ChartJS.register(ArcElement, Tooltip, Legend);
let table = new DataTable("#myTable");

const TableAdmin = () => {
  const tableRef = useRef();
  const [chartData, setChartData] = useState({
    labels: ["Label 1", "Label 2", "Label 3"],
    datasets: [
      {
        data: [30, 50, 20],
        backgroundColor: ["#FF6384", "#36A2EB", "#FFCE56"],
        hoverBackgroundColor: ["#FF6384", "#36A2EB", "#FFCE56"],
        borderWidth: 1,
      },
    ],
  });

  useEffect(() => {
    $(tableRef.current).DataTable();
  }, []);

  return (
    <div id="main">
      <div className="container-fluid px-4">
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

      <div className="row container col-md-12">
        <div className="col-lg-6 col-md-6">
          <div className="container-fluid card mb-4 p-5">
            <div className="card-header">
              <i className="fas fa-chart-pie me-1"></i>
              On-going Projects - Crops
            </div>
            <div className="card-body" style={{ height: "300px" }}>
              <Doughnut
                data={chartData}
                options={{
                  responsive: true,
                  maintainAspectRatio: false,
                }}
              />
            </div>
            <div className="card-footer small text-muted">
              Updated yesterday at 11:59 PM
            </div>
          </div>
        </div>
        <div className="col-lg-6 col-md-6">
          <div className="container-fluid card mb-4 p-5">
            <div className="card-header">
              <i className="fas fa-chart-pie me-1"></i>
              Featured Products
            </div>
            <div className="card-body" style={{ height: "300px" }}>
              <Doughnut
                data={chartData}
                options={{
                  responsive: true,
                  maintainAspectRatio: false,
                }}
              />
            </div>
            <div className="card-footer small text-muted">
              Updated yesterday at 11:59 PM
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default TableAdmin;
