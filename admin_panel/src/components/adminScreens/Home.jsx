import React, { useState, useEffect, useRef } from "react";
import "../../resources/css/Card.css";
import { useToggleState } from "./ToggleState";
import Footer from "../mainScreens/Footer";
import penCul from "../../resources/img/penCul.png";
import penPro from "../../resources/img/penPro.png";
import reqCul from "../../resources/img/reqCul.png";
import reqPro from "../../resources/img/reqPro.png";
import farmer from "../../resources/img/farmer.png";

import { Doughnut } from "react-chartjs-2";
import { Chart as ChartJS, ArcElement, Tooltip, Legend } from "chart.js";
ChartJS.register(ArcElement, Tooltip, Legend);

const Home = () => {
  const { isToggled } = useToggleState();
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
  return (
    <>
      <div id="main" className={isToggled ? "toggled" : ""}>
        <div className="container-fluid">
          <div className="total-circle-box">
            <div className="cricle1-sub-box">
              <div className="skill">
                <div className="outer">
                  <div className="inner">
                    <img src={farmer} alt="" />
                  </div>
                </div>
              </div>
              <svg
                className="svg1"
                xmlns="http://www.w3.org/2000/svg"
                version="1.1"
                width="160px"
                height="160px"
              >
                <defs>
                  <linearGradient id="GradientColor">
                    <stop offset="0%" stop-color="#e91e63" />
                    <stop offset="100%" stop-color="#673ab7" />
                  </linearGradient>
                </defs>
                <circle
                  className="circle1"
                  cx="80"
                  cy="80"
                  r="70"
                  stroke-linecap="round"
                />
              </svg>
              <h3>New Farmers</h3> <h2 className="newFar">700</h2>
            </div>
            <div className="cricle2-sub-box">
              <div className="skill">
                <div className="outer">
                  <div className="inner">
                    <img src={penCul} alt="" />
                  </div>
                </div>
              </div>
              <svg
                className="svg2"
                xmlns="http://www.w3.org/2000/svg"
                version="1.1"
                width="160px"
                height="160px"
              >
                <defs>
                  <linearGradient id="GradientColor">
                    <stop offset="0%" stop-color="#e91e63" />
                    <stop offset="100%" stop-color="#673ab7" />
                  </linearGradient>
                </defs>
                <circle
                  className="circle2"
                  cx="80"
                  cy="80"
                  r="70"
                  stroke-linecap="round"
                />
              </svg>
              <h3>Pending Cultivation</h3> <h2 className="penCul">500</h2>
            </div>
            <div className="cricle3-sub-box">
              <div className="skill">
                <div className="outer">
                  <div className="inner">
                    <img src={penPro} alt="" />
                  </div>
                </div>
              </div>
              <svg
                className="svg3"
                xmlns="http://www.w3.org/2000/svg"
                version="1.1"
                width="160px"
                height="160px"
              >
                <defs>
                  <linearGradient id="GradientColor">
                    <stop offset="0%" stop-color="#e91e63" />
                    <stop offset="100%" stop-color="#673ab7" />
                  </linearGradient>
                </defs>
                <circle
                  className="circle3"
                  cx="80"
                  cy="80"
                  r="70"
                  stroke-linecap="round"
                />
              </svg>
              <h3>Pending Products</h3> <h2 className="penPro">1000</h2>
            </div>
            <div className="cricle4-sub-box">
              <div className="skill">
                <div className="outer">
                  <div className="inner">
                    <img src={reqCul} alt="" />
                  </div>
                </div>
              </div>
              <svg
                className="svg4"
                xmlns="http://www.w3.org/2000/svg"
                version="1.1"
                width="160px"
                height="160px"
              >
                <defs>
                  <linearGradient id="GradientColor">
                    <stop offset="0%" stop-color="#e91e63" />
                    <stop offset="100%" stop-color="#673ab7" />
                  </linearGradient>
                </defs>
                <circle
                  className="circle4"
                  cx="80"
                  cy="80"
                  r="70"
                  stroke-linecap="round"
                />
              </svg>
              <h3>Req. Cultivation</h3> <h2 className="reqCul">200 </h2>
            </div>

            <div className="cricle5-sub-box">
              <div className="skill">
                <div className="outer">
                  <div className="inner">
                    <img src={reqPro} alt="" />
                  </div>
                </div>
              </div>
              <svg
                className="svg5"
                xmlns="http://www.w3.org/2000/svg"
                version="1.1"
                width="160px"
                height="160px"
              >
                <defs>
                  <linearGradient id="GradientColor">
                    <stop offset="0%" stop-color="#e91e63" />
                    <stop offset="100%" stop-color="#673ab7" />
                  </linearGradient>
                </defs>
                <circle
                  className="circle5"
                  cx="80"
                  cy="80"
                  r="70"
                  stroke-linecap="round"
                />
              </svg>
              <h3>Req. Products</h3> <h2 className="reqPro">700</h2>
            </div>
          </div>
          <hr />

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
        <Footer />
      </div>
    </>
  );
};

export default Home;
