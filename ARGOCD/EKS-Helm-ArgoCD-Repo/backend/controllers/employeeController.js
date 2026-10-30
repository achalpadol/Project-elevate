const employeeModel = require("../models/employeeModel");

// GET all employees
const getEmployees = (req, res) => {
    employeeModel.getAllEmployees((err, results) => {

        if (err) {
            console.error(err);

            return res.status(500).json({
                message: "Failed to fetch employees"
            });
        }

        res.status(200).json(results);
    });
};


// GET employee by ID
const getEmployee = (req, res) => {

    const id = req.params.id;

    employeeModel.getEmployeeById(id, (err, results) => {

        if (err) {
            console.error(err);

            return res.status(500).json({
                message: "Failed to fetch employee"
            });
        }

        if (results.length === 0) {
            return res.status(404).json({
                message: "Employee not found"
            });
        }

        res.status(200).json(results[0]);
    });
};


// CREATE employee
const createEmployee = (req, res) => {

    const { name, email, department, salary } = req.body;

    if (!name || !email || !department || salary === undefined) {
        return res.status(400).json({
            message: "All fields are required"
        });
    }

    const employee = {
        name,
        email,
        department,
        salary
    };

    employeeModel.createEmployee(employee, (err, result) => {

        if (err) {
            console.error(err);

            return res.status(500).json({
                message: "Failed to create employee"
            });
        }

        res.status(201).json({
            message: "Employee created successfully",
            employeeId: result.insertId
        });
    });
};


// UPDATE employee
const updateEmployee = (req, res) => {

    const id = req.params.id;

    const { name, email, department, salary } = req.body;

    if (!name || !email || !department || salary === undefined) {
        return res.status(400).json({
            message: "All fields are required"
        });
    }

    const employee = {
        name,
        email,
        department,
        salary
    };

    employeeModel.updateEmployee(
        id,
        employee,
        (err, result) => {

            if (err) {
                console.error(err);

                return res.status(500).json({
                    message: "Failed to update employee"
                });
            }

            if (result.affectedRows === 0) {
                return res.status(404).json({
                    message: "Employee not found"
                });
            }

            res.status(200).json({
                message: "Employee updated successfully"
            });
        }
    );
};


// DELETE employee
const deleteEmployee = (req, res) => {

    const id = req.params.id;

    employeeModel.deleteEmployee(id, (err, result) => {

        if (err) {
            console.error(err);

            return res.status(500).json({
                message: "Failed to delete employee"
            });
        }

        if (result.affectedRows === 0) {
            return res.status(404).json({
                message: "Employee not found"
            });
        }

        res.status(200).json({
            message: "Employee deleted successfully"
        });
    });
};


module.exports = {
    getEmployees,
    getEmployee,
    createEmployee,
    updateEmployee,
    deleteEmployee
};