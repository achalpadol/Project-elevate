const db = require("../config/db");

// Get all employees
const getAllEmployees = (callback) => {
    const sql = "SELECT * FROM employees ORDER BY id DESC";

    db.query(sql, callback);
};

// Get employee by ID
const getEmployeeById = (id, callback) => {
    const sql = "SELECT * FROM employees WHERE id = ?";

    db.query(sql, [id], callback);
};

// Create employee
const createEmployee = (employee, callback) => {
    const sql = `
        INSERT INTO employees
        (name, email, department, salary)
        VALUES (?, ?, ?, ?)
    `;

    const values = [
        employee.name,
        employee.email,
        employee.department,
        employee.salary
    ];

    db.query(sql, values, callback);
};

// Update employee
const updateEmployee = (id, employee, callback) => {
    const sql = `
        UPDATE employees
        SET name = ?, email = ?, department = ?, salary = ?
        WHERE id = ?
    `;

    const values = [
        employee.name,
        employee.email,
        employee.department,
        employee.salary,
        id
    ];

    db.query(sql, values, callback);
};

// Delete employee
const deleteEmployee = (id, callback) => {
    const sql = "DELETE FROM employees WHERE id = ?";

    db.query(sql, [id], callback);
};

module.exports = {
    getAllEmployees,
    getEmployeeById,
    createEmployee,
    updateEmployee,
    deleteEmployee
};