import { Link } from "react-router-dom";
import "./../styles/Navbar.css";

function Navbar() {
    return (
        <nav className="navbar">

            <div className="navbar-logo">
                <Link to="/">
                    Employee Management
                </Link>
            </div>


            <div className="navbar-links">

                <Link to="/">
                    Home
                </Link>

                <Link to="/employees">
                    Employees
                </Link>

                <Link to="/add-employee">
                    Add Employee
                </Link>

            </div>

        </nav>
    );
}

export default Navbar;