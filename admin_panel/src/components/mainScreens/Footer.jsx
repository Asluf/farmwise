import React from 'react'
import './Footer.css'

import logo from './Assets/logo.png'

export default function Footer() {
  return (
    <div className='main-footer'>
        
        
            <div className='row'>
                {/* column1 */}
                <div className='col1'>
                <img src={logo} alt=''/>                
                </div>
                
                {/* column2 */}
                <div className='col2'>
                    <h4>FARMWISE</h4>
                </div>
                
                {/* column3 */}
                <div className='col3'>
                    <h4>farmwise</h4>
                    <ul className='unorder-list'>
                        <li>name</li>
                        <li>address</li>
                    </ul>

                </div>
            </div>
            
             
    </div>
  )
}
