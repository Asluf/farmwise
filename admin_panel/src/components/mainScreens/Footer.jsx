import React from "react";
import "../../resources/css/footer.css";

import fbImg from "./Assets/fblmg.png"
import twitterImg from "./Assets/twitterImg.png"
import instaImg from "./Assets/instaImg.png"
// import linkImg from "./Assets/linkImg.jpg"
// import mailImg from "./Assets/mailImg.jpeg"

export default function Footer() {
  return (
    <footer className="footer mt-auto">
      <div className="main-footer">
        {/* Row 1 */}
        <div className="row1">
          <img src={fbImg} alt="" />
          <img src={twitterImg} alt="" />
          {/* <img src={mailImg} alt="" /> */}
          <img src={instaImg} alt="" />
          {/* <img src={linkImg} alt="" /> */}
        </div> 

        {/* Row 2 */}
        <div className="row2">
          <div className="col1">
            <h4>CONTACT INFO</h4>
            <ul className="unorder-list">
              <li>TEL: 011-000-0000</li>
              <li>EMAIL: farmwise@gmail.com</li>              
            </ul>
          </div>

          <div className="col2">
            <h4>QUICK LINKS</h4>
            <ul className="unorder-list">
            <li><a href="/farmwise">Farmwise</a></li>
            <li><a href="/about">About</a></li>
            </ul>
          </div>
        </div>
        

        <hr />

        {/* Row 3 */}
        <div className="row3">
          <p>
            &copy;{new Date().getFullYear()} FARMWISE | All right reserved | Terms of service | Privacy
          </p>
        </div>
      </div>
    </footer>
  );
}


