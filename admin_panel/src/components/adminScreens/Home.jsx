import React from "react";
import "./Card.css";
import { useToggleState } from "./ToggleState";
import Footer from '../mainScreens/Footer';
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
                {(index + 1) % columns === 0 && <div className="column-spacing" />}
              </React.Fragment>
            ))}
          </div>
        </div>
        <Footer/>
      </div>
    </>
  );
};

export default Home;
