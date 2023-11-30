import React, { useEffect, useRef } from "react";
import "datatables.net-dt/css/jquery.dataTables.css"; // Import DataTables CSS
import $ from "jquery";
import "popper.js";
import DataTable from "datatables.net-dt";

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
    </div>
  );
};

export default TableAdmin;
