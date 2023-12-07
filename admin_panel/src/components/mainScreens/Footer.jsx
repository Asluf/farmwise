import React from "react";
import { Link, Outlet } from "react-router-dom";
import "../../resources/css/footer.css";
import fbImg from "../../resources/Assets/fblmg.png";
import twitterImg from "../../resources/Assets/twitterImg.png";
import instaImg from "../../resources/Assets/instaImg.png";
import gmail from "../../resources/Assets/gmail.png";
import linkedin from "../../resources/Assets/linkedin.png";

export default function Footer() {
  return (
    <footer className="footer mt-auto">
      <div className="main-footer container-fluid">
        <div className="links">
          <img src={fbImg} alt="" />
          <img src={twitterImg} alt="" />
          <img src={instaImg} alt="" />
          <img src={gmail} alt="" />
          <img src={linkedin} alt="" />
        </div>

        {/* Row 2 */}
        <div className="row2 col-md-12 col-sm-12">
          <div className="col-md-2"></div>
          <div className="col-md-4 col-sm-6">
            <h4>CONTACT INFO</h4>
            <ul className="unorder-list">
              <li>TEL: 011-000-0000</li>
              <li>EMAIL: farmwise@gmail.com</li>
            </ul>
          </div>
          <div className="col-md-2"></div>

          <div className="col-md-4 col-sm-6">
            <h4>QUICK LINKS</h4>
            <ul className="unorder-list">
              <li>
                <Link to="/">Home</Link>
              </li>
              <li>
                <Link to="about">About </Link>
              </li>
            </ul>
          </div>
        </div>

        <hr />

        {/* Row 3 */}
        <div className="row3">
          <p className="text-light fw-bold">
            &copy;{new Date().getFullYear()} FARMWISE | All right reserved |
            Terms of service | Privacy
          </p>
        </div>
      </div>
      <Outlet />
    </footer>
  );
}
