import { React } from "react";
import { Link, Outlet } from "react-router-dom";
import { useToggleState } from './ToggleState';
import '../../resources/css/sha.css';

export default function AdminSideBar() {
    const { isToggled, toggle } = useToggleState();

    return (
        <>
            <div id="sidebar" className={isToggled ? 'toggled' : ''}>
                <Link onClick={toggle}><i id="bars" className="fa fa-bars" aria-hidden="true"></i></Link>
                <Link to='/' className='navbar-brand' title="Farmwise"><i className="fas fa-seedling"></i><span id="navText">Farmwise</span></Link>
                <Link to='about'><i className="fas fa-info-circle"></i><span id="navText">About</span></Link>
                <div className="hrLine">
                    <hr />
                </div>
                <div className="dropdown">
                    <Link className="dropbtn"><i className="fa fa-tree"></i><span id="navText">Farmer</span></Link>
                    <div className="dropdown-content" >
                        <Link to="farmerManage" style={{ padding: "8px" }}><span className="dropText">Manage</span> </Link>
                        <Link to="pendingProduct" style={{ padding: "8px" }}><span className="dropText">Pending Products</span></Link>
                        <Link to="#" style={{ padding: "8px" }}><span className="dropText">Pending Cultivation</span></Link>
                        <Link to="#" style={{ padding: "8px" }}><span className="dropText">Ongoing Cultivation</span></Link>
                    </div>
                </div>
                <div className="dropdown">
                    <Link className="dropbtn"><i className="fa fa-briefcase"></i><span id="navText">Invester</span></Link>
                    <div className="dropdown-content" >
                        <Link to="#" style={{ padding: "8px" }}><span className="dropText">Manage</span> </Link>
                        <Link to="#" style={{ padding: "8px" }}><span className="dropText">Link 2</span></Link>
                        <Link to="#" style={{ padding: "8px" }}><span className="dropText">Link 3</span></Link>
                    </div>
                </div>
                <div className="dropdown">
                    <Link className="dropbtn"><i className="fa fa-user-circle"></i><span id="navText">Buyer</span></Link>
                    <div className="dropdown-content" >
                        <Link to="#" style={{ padding: "8px" }}><span className="dropText">Manage</span> </Link>
                        <Link to="#" style={{ padding: "8px" }}><span className="dropText">Ongoing Orders</span></Link>
                        <Link to="#" style={{ padding: "8px" }}><span className="dropText">Pending Orders</span></Link>
                    </div>
                </div>
                <div className="logout">
                    <Link to='#'><i className="fa fa-lock"></i><span id="navText">Logout</span></Link>
                </div>
            </div>
            <Outlet />
        </>
    );
}