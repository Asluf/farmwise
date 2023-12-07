import React from "react";
import { useToggleState } from "../../ToggleState";
import { useNavigate, useParams } from "react-router-dom";

export default function FarmerDetails() {
  const navigate = useNavigate();
  const { id } = useParams();
  const { isToggled } = useToggleState();
  return (
    <div id="main" className={isToggled ? "toggled" : ""}>
      <div className="container-fluid">
        {/* Nasik: Do the working under this line. 
         create the css files in resources/css folder */}
        <h2>Do here Nasik</h2>
      </div>
    </div>
  );
}
