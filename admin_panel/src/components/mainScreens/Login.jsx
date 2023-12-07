import React, { useState } from 'react';
import "../../resources/css/Login.css";

import person_icon from '../../resources/Assets/person_icon.png';
import password_icon from '../../resources/Assets/password_icon.png';
import logo from "../../resources/Assets/logo.png";

export default function Login() {

  const [values, setValues] = useState({
    name: '',
    password: ''
  });

  const [errors, setErrors] = useState({
    name: '',
    password: ''
  });

  function handleChange(e) {
    setValues({ ...values, [e.target.name]: e.target.value });
  }

  function handleSubmit(e) {
    e.preventDefault();
    const validationErrors = validation(values);
    if (validationErrors) {
      setErrors(validationErrors);
      console.log('Form validation failed.');
    } else {
      setErrors({ name: '', password: '' });
      console.log('Form is valid, perform login action here.');
    }
  }

  function validation(values) {
    let errors = { name: '', password: '' };
    if (values.name.trim() === '') {
      errors.name = 'Username is required';
    }
    if (values.password.trim() === '') {
      errors.password = 'Password is required';
    }
    
    return Object.values(errors).some(val => val) ? errors : null;
  }

  return (
    <div className='background-image'>
      <div className='sub-container'>
        <form onSubmit={handleSubmit}>
          <div className='row1'>
            <img src={logo} alt="" />
            <h1>FARMWISE</h1>
          </div>

          <div className='header'>
            <div className='text'>Login</div>
          </div>

          <div className='inputs'>
            <div className='user-input'>
              <img src={person_icon} alt='' />
              <input type='text' placeholder='Username' value={values.name} name='name' onChange={handleChange} />
              <div className='error-message'>{errors.name}</div>
            </div>
            <div className='user-input'>
              <img src={password_icon} alt='' />
              <input type='password' placeholder='Password' value={values.password} name='password' onChange={handleChange}  />
              <div className='error-message'>{errors.password}</div>
            </div>
          </div>

          <div className='forgot-password'>Forgot Password?</div>

          <div className='submit-container'>
            <button type='submit'>Login</button>
          </div>
        </form>
      </div>
    </div>
  );
}
