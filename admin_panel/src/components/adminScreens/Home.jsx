import React from "react";
import "./Card.css";
import { useToggleState } from "./ToggleState";
import Footer from "../mainScreens/Footer";
<<<<<<< admin_panel/src/components/adminScreens/Home.jsx
import "../../resources/css/Card.css";

const Card = ({ imageUrl, title, content }) => {
  return (
    <div className="card">
      <img src={imageUrl} alt={title} />
      <div className="card-content">
        <h2 className="card-title">{title}</h2>
        <p>{content}</p>
        <button className="card-button">Click me</button>
      </div>
    </div>
  );
};
=======
>>>>>>> admin_panel/src/components/adminScreens/Home.jsx

const Home = () => {
  const { isToggled } = useToggleState();


  return (
    <>
      <div id="main" className={isToggled ? "toggled" : ""}>
        <div className="container-fluid">

          <div className="row d-flex col-md-12">
            <div className="col-md-3 mr-3">
              <div className="card m-3">
                <div className="card-content">
                  <h2 className="card-title">ygygygy</h2>
                  <p>ughyghhb</p>
                  <button className="card-button">Click me</button>
                </div>
              </div>
            </div>
            <div className="col-md-3 mr-3">
              <div className="card m-3">
                <div className="card-content">
                  <h2 className="card-title">ygygygy</h2>
                  <p>ughyghhb</p>
                  <button className="card-button">Click me</button>
                </div>
              </div>
            </div>
            <div className="col-md-3 mr-3">
              <div className="card m-3">
                <div className="card-content">
                  <h2 className="card-title">ygygygy</h2>
                  <p>ughyghhb</p>
                  <button className="card-button">Click me</button>
                </div>
              </div>
            </div>
            <div className="col-md-3 mr-3">
              <div className="card m-3">
                <div className="card-content">
                  <h2 className="card-title">ygygygy</h2>
                  <p>ughyghhb</p>
                  <button className="card-button">Click me</button>
                </div>
              </div>
            </div>
            
          </div>
          
        </div>

        <Footer />
      </div>
    </>
  );
};

export default Home;
