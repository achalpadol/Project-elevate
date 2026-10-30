const express = require("express");
const cors = require("cors");
require("dotenv").config();

require("./config/db");

const employeeRoutes = require("./routes/employeeRoutes");

const app = express();


// Middleware
app.use(cors());
app.use(express.json());


// Root route
app.get("/", (req, res) => {
    res.send("Employee Management Backend Running...");
});


// Employee routes
app.use("/api/employees", employeeRoutes);


// Server
const PORT = process.env.PORT || 5000;

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});