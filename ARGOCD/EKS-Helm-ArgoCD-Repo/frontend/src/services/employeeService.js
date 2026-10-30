import axios from "axios";

const API_URL = "/api/employees";


export const getEmployees = () => {
    return axios.get(API_URL);
};


export const getEmployeeById = (id) => {
    return axios.get(`${API_URL}/${id}`);
};


export const createEmployee = (employee) => {
    return axios.post(API_URL, employee);
};


export const updateEmployee = (id, employee) => {
    return axios.put(`${API_URL}/${id}`, employee);
};


export const deleteEmployee = (id) => {
    return axios.delete(`${API_URL}/${id}`);
};