import {React} from "react";
import { Link, Outlet } from "react-router-dom";
import { useToggleState } from './ToggleState';

export default function AdminSideBar() {
    const { isToggled, toggle } = useToggleState();

    return (
        <>
            <div id="sidebar" className={isToggled ? 'toggled' : ''}>
                <Link onClick={toggle }><i class="fa fa-bars" aria-hidden="true"></i></Link>
                <Link to='/' className='navbar-brand'><i className="fas fa-seedling"></i><span id="navText">Farmwise</span></Link>
                <Link to='about'><i className="fas fa-info-circle"></i><span id="navText">About</span></Link>
                {/* <Link to='about'><i className="fas fa-link"></i><span id="navText">Contact</span></Link> */}
            </div>
            <Outlet />
        </>
    );
}