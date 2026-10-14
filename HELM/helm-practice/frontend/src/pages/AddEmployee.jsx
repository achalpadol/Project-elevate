import { useState } from "react";
import { useNavigate } from "react-router-dom";

import { createEmployee } from "../services/employeeService";


function AddEmployee() {

    const navigate = useNavigate();


    const [formData, setFormData] = useState({
        name: "",
        email: "",
        department: "",
        salary: ""
    });


    const [error, setError] = useState("");


    // Handle input changes
    const handleChange = (event) => {

        const { name, value } = event.target;

        setFormData({
            ...formData,
            [name]: value
        });
    };


    // Submit form
    const handleSubmit = async (event) => {

        event.preventDefault();

        setError("");


        try {

            await createEmployee({
                ...formData,
                salary: Number(formData.salary)
            });


            alert("Employee added successfully");


            // Go to employees page
            navigate("/employees");


        } catch (error) {

            console.error(error);

            setError("Failed to add employee");

        }
    };


    return (
        <div>

            <h1>Add Employee</h1>


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
                    Add Employee
                </button>

            </form>

        </div>
    );
}


export default AddEmployee;