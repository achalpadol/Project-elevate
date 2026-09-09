const express = require("express");

const router = express.Router();

const {
    getEmployees,
    getEmployee,
    createEmployee,
    updateEmployee,
    deleteEmployee
} = require("../controllers/employeeController");


// GET all employees
router.get("/", getEmployees);

// GET employee by ID
router.get("/:id", getEmployee);

// CREATE employee
router.post("/", createEmployee);

// UPDATE employee
router.put("/:id", updateEmployee);

// DELETE employee
router.delete("/:id", deleteEmployee);


module.exports = router;