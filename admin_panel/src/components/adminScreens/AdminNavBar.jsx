import React, { useState } from "react";
import "../../resources/css/styles.css";
import "../../resources/css/sidebar.css";
import {Link, Outlet} from "react-router-dom";

function NavBar() {

  return (
    <>
      <nav className="navbar navbar-expand-lg navbar-light bg-light" style={{background:'linear-gradient(to right, #00cc99, #006666)'}}>
        <a className="navbar-brand" href="#">
          Navbar
        </a>
        <button
          className="navbar-toggler"
          type="button"
          data-toggle="collapse"
          data-target="#navbarSupportedContent"
          aria-controls="navbarSupportedContent"
          aria-expanded="false"
          aria-label="Toggle navigation"
        >
          <span className="navbar-toggler-icon"></span>
        </button>

        <div className="collapse navbar-collapse" id="navbarSupportedContent">
          <ul className="navbar-nav mr-auto">
            <li className="nav-item active">
              <Link className="nav-link" to="/">Home</Link>
            </li>
            <li className="nav-item">
              <Link className="nav-link" to="about">About</Link>
            </li>
            {/* <li className="nav-item">
              <Link className="nav-link" to="login">Logout</Link>
            </li> */}
          </ul>
          
        </div>
      </nav>
      <Outlet/>
    </>
  );
}

export default NavBar;
