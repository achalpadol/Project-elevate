import { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";

import {
    getEmployeeById,
    updateEmployee
} from "../services/employeeService";


function EditEmployee() {

    const { id } = useParams();

    const navigate = useNavigate();


    const [formData, setFormData] = useState({
        name: "",
        email: "",
        department: "",
        salary: ""
    });


    const [loading, setLoading] = useState(true);
    const [error, setError] = useState("");


    // Fetch employee
    useEffect(() => {

        const fetchEmployee = async () => {

            try {

                const response = await getEmployeeById(id);

                setFormData({
                    name: response.data.name,
                    email: response.data.email,
                    department: response.data.department,
                    salary: response.data.salary
                });

            } catch (error) {

                console.error(error);

                setError("Failed to load employee");

            } finally {

                setLoading(false);

            }
        };


        fetchEmployee();

    }, [id]);


    // Handle input
    const handleChange = (event) => {

        const { name, value } = event.target;

        setFormData({
            ...formData,
            [name]: value
        });
    };


    // Update employee
    const handleSubmit = async (event) => {

        event.preventDefault();

        setError("");


        try {

            await updateEmployee(id, {
                ...formData,
                salary: Number(formData.salary)
            });


            alert("Employee updated successfully");

            navigate("/employees");

        } catch (error) {

            console.error(error);

            setError("Failed to update employee");

        }
    };


    if (loading) {
        return <h2>Loading employee...</h2>;
    }


    if (error && !formData.name) {
        return <h2>{error}</h2>;
    }


    return (
        <div>

            <h1>Edit Employee</h1>


            {error && (
                <p>{error}</p>
            )}


            <form onSubmit={handleSubmit}>

                <div>

                    <label>Name</label>

                    <input
                        type="text"
                        name="name"
                        value={formData.name}
                        onChange={handleChange}
                        required
                    />

                </div>


                <br />


                <div>

                    <label>Email</label>

                    <input
                        type="email"
                        name="email"
                        value={formData.email}
                        onChange={handleChange}
                        required
                    />

                </div>


                <br />


                <div>

                    <label>Department</label>

                    <input
                        type="text"
                        name="department"
                        value={formData.department}
                        onChange={handleChange}
                        required
                    />

                </div>


                <br />


                <div>

                    <label>Salary</label>

                    <input
                        type="number"
                        name="salary"
                        value={formData.salary}
                        onChange={handleChange}
                        required
                    />

                </div>


                <br />


                <button type="submit">
                    Update Employee
                </button>


                <button
                    type="button"
                    onClick={() => navigate("/employees")}
                >
                    Cancel
                </button>

            </form>

        </div>
    );
}


export default EditEmployee;