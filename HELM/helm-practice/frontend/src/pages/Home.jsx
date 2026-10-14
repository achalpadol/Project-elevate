import { Link } from "react-router-dom";
import "../styles/Home.css";

function Home() {

    return (
        <div className="home-container">

            <h1>Employee Management System</h1>

            <p>
                Manage your organization's employees
                efficiently from one place.
            </p>

            <Link to="/employees">
                <button className="primary-button">
                    View Employees
                </button>
            </Link>

        </div>
    );
}

export default Home;