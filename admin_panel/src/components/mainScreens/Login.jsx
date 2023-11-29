import React, { useState } from 'react'
import './Login.css'

import person_icon from './Assets/person_icon.png'
import password_icon from './Assets/password_icon.png'
import bgLeaves from './Assets/bgLeaves.jpg' 

export default function Login() {
  
  const[action,setAction] = useState("Login");

  return (
    <div className='background-image'>
    <div className='sub-container'>
      <div className='header'>
        <div className='text'>{action}</div>
        
      </div>
      
      <div className='inputs'>
        <div className='input'>
            <img src={person_icon} alt=''/>
            <input type='text' placeholder='Username'/>
        </div>
        <div className='input'>
            <img src={password_icon} alt=''/>
            <input type='password' placeholder='Password'/>
        </div>        
      </div>

      {action==="Sign Up"?<div></div>:<div className='forgot-password'>Forgot Password?</div>}
      
      <div className='submit-container'>
        <div className={action==="Login"?"submit gray":"submit"} onClick={()=>{setAction("Sign Up")}}>Sign Up</div>
        <div className={action==="Sign Up"?"submit gray":"submit"} onClick={()=>{setAction("Login")}}>Login</div>
      </div>
    </div>
    </div>
  )
}
