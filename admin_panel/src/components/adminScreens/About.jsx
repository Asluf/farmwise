import React from "react";
import { useToggleState } from "./ToggleState";
export default function About() {
  const { isToggled } = useToggleState();
  return (
    <div id="main" className={isToggled ? "toggled" : ""}>
      <div className="container-fluid">
        <h1>About</h1>
        <h1>About</h1>
        <h1>About</h1>
      </div>
    </div>
  );
}
