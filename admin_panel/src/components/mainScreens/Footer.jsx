import React from "react";
import "../../resources/css/footer.css";

import logo from "./Assets/logo.png";

export default function Footer() {
  return (
    // <div className="fixed-bottom">
    //   <div className="main-footer">
    //     <div className="row">
    //       <div className="col1">
    //         <img src={logo} alt="" />
    //       </div>

    //       <div className="col2">
    //         <h4>FARMWISE</h4>
    //       </div>

    //       <div className="col3">
    //         <h4>farmwise</h4>
    //         <ul className="unorder-list">
    //           <li>name</li>
    //           <li>address</li>
    //         </ul>
    //       </div>
    //     </div>
    //   </div>
    // </div>

    <footer class="footer mt-auto">
      {/* <div class="container"> */}
      {/* <span class="text-muted">Your Footer Content Goes Here</span> */}
      <div className="main-footer">
        <div className="row">
          <div className="col1">
            <img src={logo} alt="" />
          </div>

          <div className="col2">
            <h4>FARMWISE</h4>
          </div>

          <div className="col3">
            <h4>farmwise</h4>
            <ul className="unorder-list">
              <li>name</li>
              <li>address</li>
            </ul>
          </div>
        </div>
      </div>
      {/* </div> */}
    </footer>
  );
}
