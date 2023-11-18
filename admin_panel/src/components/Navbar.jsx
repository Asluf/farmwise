import React, { useState } from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import Container from 'react-bootstrap/Container';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import NavDropdown from 'react-bootstrap/NavDropdown';
import { Form , Button } from 'react-bootstrap';
import {
  BrowserRouter as Router,
  Route,
  Link,
  Routes
} from "react-router-dom";

import Home from "./Home";
import Contact from './Contact';
import About from './About';
import './styles.css'; 
import Sidebar from './Sidebar';
import './Sidebar.css';

function NavBar() {
  const [showSidebar, setShowSidebar] = useState(false);

  const toggleSidebar = () => {
    setShowSidebar(!showSidebar);
  };
  return (
    <Router>
       <div className={`wrapper ${showSidebar ? 'show-sidebar' : ''}`}>
        <Button className="sidebar-toggle" onClick={toggleSidebar}>
          {/* You can use an icon here, like a hamburger icon */}
          ☰
        </Button>
        <Sidebar /> {/* Include the Sidebar component */}
        <div className="main-content"></div>
    <Navbar style={{ background: 'linear-gradient(to right, #00cc99, #006666)' }} expand="lg" variant="dark"> 
      <Container>
        <Navbar.Brand href="#home">
        <img
              src='./images/logo.png' // Replace 'YourLogo' with the actual path to your logo
              alt="Your Logo"
              width="30"
              height="30"
              className="d-inline-block align-top"
            />{' '}
          FARMWISE</Navbar.Brand>
        <Navbar.Toggle aria-controls="basic-navbar-nav" />
        <Navbar.Collapse id="basic-navbar-nav">
          <Nav className="me-auto">
            <Nav.Link as={Link} to={"home"}>Home</Nav.Link>
            <Nav.Link as={Link} to={"about"}>About</Nav.Link>
            <Nav.Link as={Link} to={"contact"}>Contact us</Nav.Link>
            <NavDropdown title="Dropdown" id="basic-nav-dropdown">
              <NavDropdown.Item href="#action/3.1">Action</NavDropdown.Item>
              <NavDropdown.Item href="#action/3.2">
                Another action
              </NavDropdown.Item>
              <NavDropdown.Item href="#action/3.3">Something</NavDropdown.Item>
              <NavDropdown.Divider />
              <NavDropdown.Item href="#action/3.4">
                Separated link
              </NavDropdown.Item>
            </NavDropdown>
          </Nav>
          <Form className="d-flex">
            <Form.Control
              type="search"
              placeholder="Search"
              className="me-2"
              aria-label="Search"
            />
            <Button variant="secondary">Search</Button>
          </Form>
        </Navbar.Collapse>
      </Container>
    </Navbar>
    <div>
    <Routes>
    <Route path="home" element={<Home />} />
          <Route path="about" element={<About />} />
          <Route path="contact" element={<Contact />} />
        </Routes>
    </div>
    </div>
    </Router>
  );
}

export default NavBar;
