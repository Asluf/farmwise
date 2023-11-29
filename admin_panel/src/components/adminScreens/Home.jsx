import React from "react";
import { useToggleState } from './ToggleState';
import FooterContent from "./FooterContent";
export default function Home() {
  const { isToggled, toggle } = useToggleState();
  return (
    <>
      <div id="main" className={isToggled ? 'toggled' : ''}>
        {/* <NavBar /> */}
        <div className="container-fluid">
          <h1>Home</h1>
        </div>
        <FooterContent />
      </div>
    </>
  );
}
