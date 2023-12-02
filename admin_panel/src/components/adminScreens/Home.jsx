import React from "react";
import "./Card.css";
import { useToggleState } from "./ToggleState";
import Footer from "../mainScreens/Footer";
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

const Home = () => {
  const { isToggled } = useToggleState();

  // Sample data for cards
  const cardData = [
    { imageUrl: "url1", title: "Proposal 1", content: "I make a proposal 1" },
    { imageUrl: "url2", title: "Proposal 2", content: "I make a proposal 2" },
    { imageUrl: "url3", title: "Proposal 3", content: "I make a proposal 3" },
    { imageUrl: "url4", title: "Proposal 4", content: "I make a proposal 4" },
    { imageUrl: "url5", title: "Proposal 5", content: "I make a proposal 5" },
    { imageUrl: "url6", title: "Proposal 6", content: "I make a proposal 6" },
    { imageUrl: "url7", title: "Proposal 7", content: "I make a proposal 7" },
    { imageUrl: "url8", title: "Proposal 8", content: "I make a proposal 8" },
    // Add more card data as needed
  ];

  const columns = 4;
  // Number of cards in each row

  return (
    <>
      <div id="main" className={isToggled ? "toggled" : ""}>
        <div className="container-fluid">
          <div className="card-grid">
            {cardData.map((card, index) => (
              <React.Fragment key={index}>
                <Card {...card} />
                {(index + 1) % columns === 0 && (
                  <div className="column-spacing" />
                )}
              </React.Fragment>
            ))}
          </div>
        </div>

        <div class="total-circle-box">
          <div class="cricle1-sub-box">
            <div class="skill">
              <div class="outer">
                <div class="inner">
                  <img
                    src="<?php echo base_url(); ?>resources/frontend/img/total.png"
                    alt=""
                  />
                </div>
              </div>
            </div>
            <svg
              class="svg1"
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
                class="circle1"
                cx="80"
                cy="80"
                r="70"
                stroke-linecap="round"
              />
            </svg>
            <h3>Total Stocks</h3>
            <h2 class="totalNumber">700</h2>
          </div>
          <div class="cricle2-sub-box">
            <div class="skill">
              <div class="outer">
                <div class="inner">
                  <img
                    src="<?php echo base_url(); ?>resources/frontend/img/avilable.png"
                    alt=""
                  />
                </div>
              </div>
            </div>
            <svg
              class="svg2"
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
                class="circle2"
                cx="80"
                cy="80"
                r="70"
                stroke-linecap="round"
              />
            </svg>
            <h3>Available Stocks</h3>
            <h2 class="avilableStocks">500</h2>
          </div>
          <div class="cricle3-sub-box">
            <div class="skill">
              <div class="outer">
                <div class="inner">
                  <img
                    src="<?php echo base_url(); ?>resources/frontend/img/Low stock.png"
                    alt=""
                  />
                </div>
              </div>
            </div>
            <svg
              class="svg3"
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
                class="circle3"
                cx="80"
                cy="80"
                r="70"
                stroke-linecap="round"
              />
            </svg>
            <h3>Low Stocks</h3>
            <h2 class="lowStock">1000</h2>
          </div>
          <div class="cricle4-sub-box">
            <div class="skill">
              <div class="outer">
                <div class="inner">
                  <img
                    src="<?php echo base_url(); ?>resources/frontend/img/unavilable.png"
                    alt=""
                  />
                </div>
              </div>
            </div>
            <svg
              class="svg4"
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
                class="circle4"
                cx="80"
                cy="80"
                r="70"
                stroke-linecap="round"
              />
            </svg>
            <h3>Out Of Stocks</h3>
            <h2 class="outOfStock">200 </h2>
          </div>
        </div>
        <Footer />
      </div>
    </>
  );
};

export default Home;
