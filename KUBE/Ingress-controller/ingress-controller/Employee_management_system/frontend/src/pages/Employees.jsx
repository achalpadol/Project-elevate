import { useEffect, useState } from "react";

import {
    getEmployees,
    deleteEmployee
} from "../services/employeeService";

import { Link } from "react-router-dom";

import "../styles/Employees.css";


function Employees() {

    const [employees, setEmployees] = useState([]);

    const [search, setSearch] = useState("");

    const [loading, setLoading] = useState(true);

    const [error, setError] = useState("");


    // Fetch employees
    const fetchEmployees = async () => {

        try {

            const response = await getEmployees();

            setEmployees(response.data);

        } catch (error) {

            console.error(error);

            setError("Failed to load employees");

        } finally {

            setLoading(false);

        }
    };


    useEffect(() => {

        fetchEmployees();

    }, []);


    // Delete employee
    const handleDelete = async (id) => {

        const confirmDelete = window.confirm(
            "Are you sure you want to delete this employee?"
        );


        if (!confirmDelete) {
            return;
        }


        try {

            await deleteEmployee(id);

            fetchEmployees();

        } catch (error) {

            console.error(error);

            alert("Failed to delete employee");

        }
    };


    // Search employees
    const filteredEmployees = employees.filter((employee) => {

        const searchValue = search.toLowerCase();

        return (
            employee.name.toLowerCase().includes(searchValue) ||
            employee.email.toLowerCase().includes(searchValue) ||
            employee.department.toLowerCase().includes(searchValue)
        );

    });


    if (loading) {

        return (
            <div className="page-container">
                <h2>Loading employees...</h2>
            </div>
        );

    }


    if (error) {

        return (
            <div className="page-container">
                <h2>{error}</h2>
            </div>
        );

    }


    return (

        <div className="page-container">


            {/* Header */}

            <div className="page-header">

                <div>

                    <h1>Employees</h1>

                    <p>
                        Manage all employees
                    </p>

                </div>


                <Link to="/add-employee">

                    <button className="add-button">
                        + Add Employee
                    </button>

                </Link>

            </div>


            {/* Statistics */}

            <div className="stats-container">

                <div className="stat-card">

                    <h3>Total Employees</h3>

                    <p>
                        {employees.length}
                    </p>

                </div>


                <div className="stat-card">

                    <h3>Departments</h3>

                    <p>
                        {
                            new Set(
                                employees.map(
                                    employee => employee.department
                                )
                            ).size
                        }
                    </p>

                </div>


                <div className="stat-card">

                    <h3>Total Salary</h3>

                    <p>

                        ₹
                        {
                            employees.reduce(
                                (total, employee) =>
                                    total + Number(employee.salary),
                                0
                            )
                        }

                    </p>

                </div>

            </div>


            {/* Search */}

            <div className="search-container">

                <input
                    type="text"
                    placeholder="Search by name, email or department..."
                    value={search}
                    onChange={(event) =>
                        setSearch(event.target.value)
                    }
                />

            </div>


            {/* Table */}

            <div className="table-container">

                {filteredEmployees.length === 0 ? (

                    <p className="no-data">
                        No employees found.
                    </p>

                ) : (

                    <table>

                        <thead>

                            <tr>

                                <th>ID</th>

                                <th>Name</th>

                                <th>Email</th>

                                <th>Department</th>

                                <th>Salary</th>

                                <th>Actions</th>

                            </tr>

                        </thead>


                        <tbody>

                            {filteredEmployees.map(
                                (employee) => (

                                    <tr key={employee.id}>

                                        <td>
                                            {employee.id}
                                        </td>

                                        <td>
                                            {employee.name}
                                        </td>

                                        <td>
                                            {employee.email}
                                        </td>

                                        <td>
                                            {employee.department}
                                        </td>

                                        <td>
                                            ₹{employee.salary}
                                        </td>

                                        <td>

                                            <div className="action-buttons">

                                                <Link
                                                    to={`/edit-employee/${employee.id}`}
                                                >

                                                    <button className="edit-button">
                                                        Edit
                                                    </button>

                                                </Link>


                                                <button
                                                    className="delete-button"
                                                    onClick={() =>
                                                        handleDelete(
                                                            employee.id
                                                        )
                                                    }
                                                >
                                                    Delete
                                                </button>

                                            </div>

                                        </td>

                                    </tr>

                                )
                            )}

                        </tbody>

                    </table>

                )}

            </div>

        </div>
    );
}

export default Employees;