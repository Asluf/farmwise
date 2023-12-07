import React from "react";
import { useToggleState } from "../../ToggleState";
import { useNavigate, useParams } from "react-router-dom";

export default function PendingProductDetails() {
  const navigate = useNavigate();
  const { id } = useParams();
  const { isToggled } = useToggleState();
  return (
    <div id="main" className={isToggled ? "toggled" : ""}>
      <div className="container-fluid">
        {/* Sha: Do the working under this line. 
         create the css files in resources/css folder */}
        <h2>Do here sha</h2>
      </div>
    </div>
  );
}
