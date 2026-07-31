# React + Spring Boot CRUD Full Stack Application

A Full Stack Employee Management System built using:

- React.js (Frontend)
- Spring Boot (Backend)
- MySQL (AWS RDS)
- Docker
- Docker Compose
- Nginx

---

# Architecture

```
                Browser
                    │
                    │
               Port 80
                    │
              React + Nginx
                    │
          /api/v1/employees
                    │
            Spring Boot API
                    │
               Port 8080
                    │
               AWS RDS MySQL
```

---

# Project Structure

```
ReactJS-Spring-Boot-CRUD-Full-Stack-App
│
├── docker-compose.yml
│
├── react-frontend
│   ├── Dockerfile
│   ├── nginx.conf
│   ├── package.json
│   └── src/
│
└── springboot-backend
    ├── Dockerfile
    ├── pom.xml
    └── src/
```

---

# Prerequisites

Install the following:

- Git
- Java 17
- Maven
- Docker
- Docker Compose
- AWS RDS MySQL Database

---

# Clone Repository

```bash
git clone https://github.com/achalpadol/ReactJS-Spring-Boot-CRUD-Full-Stack-App.git

cd ReactJS-Spring-Boot-CRUD-Full-Stack-App
```

---

# Configure AWS RDS

Create a MySQL Database

Example

```
Database Name

employee_management_system
```

Connect to RDS

```bash
mysql -h my-rds.c214w64cecep.us-east-1.rds.amazonaws.com \
-u admin \
-p
```

Create Database

```sql
CREATE DATABASE employee_management_system;
```

---

# Configure Spring Boot

Open

```
springboot-backend/src/main/resources/application.properties
```

Update

```properties
spring.datasource.url=jdbc:mysql://<RDS-ENDPOINT>:3306/employee_management_system?useSSL=false

spring.datasource.username=admin

spring.datasource.password=YourPassword

spring.jpa.hibernate.ddl-auto=update

spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQLDialect
```

---

# Configure React

Open

```
react-frontend/src/services/EmployeeService.js
```

Change

```javascript
const EMPLOYEE_API_BASE_URL="/api/v1/employees";
```

Do NOT use

```javascript
http://localhost:8080
```

because Nginx forwards API requests automatically.

---

# Dockerfile (Backend)

Location

```
springboot-backend/Dockerfile
```

Builds the Spring Boot application and exposes port 8080.

---

# Dockerfile (Frontend)

Location

```
react-frontend/Dockerfile
```

Uses a multi-stage build

Stage 1

- Node
- Build React application

Stage 2

- Nginx
- Serve production build

---

# Docker Compose

Location

```
docker-compose.yml
```

This starts

- Spring Boot Container
- React Container

The application connects directly to AWS RDS.

---

# Build Docker Images

Run

```bash
docker compose build
```

---

# Start Containers

```bash
docker compose up -d
```

---

# Check Running Containers

```bash
docker ps
```

Example

```
springboot-backend

react-frontend
```

---

# Check Logs

Backend

```bash
docker logs springboot-backend
```

Frontend

```bash
docker logs react-frontend
```

Live Logs

```bash
docker compose logs -f
```

---

# Verify Backend

```bash
curl http://localhost:8080/api/v1/employees
```

Expected

```json
[
  {
    "id":1,
    "firstName":"John",
    "lastName":"Doe"
  }
]
```

---

# Verify Frontend

```bash
curl http://localhost
```

or

Open browser

```
http://<EC2-Public-IP>
```

---

# Stop Containers

```bash
docker compose down
```

---

# Restart Containers

```bash
docker compose restart
```

---

# Rebuild After Code Changes

```bash
docker compose down

docker compose up --build -d
```

---

# Useful Docker Commands

List Containers

```bash
docker ps
```

All Containers

```bash
docker ps -a
```

List Images

```bash
docker images
```

Remove Containers

```bash
docker rm -f $(docker ps -aq)
```

Remove Images

```bash
docker rmi $(docker images -q)
```

Clean Docker

```bash
docker system prune -a
```

---

# Common Issues

## Docker Compose Not Found

Install

```bash
sudo apt install docker-compose-v2
```

Use

```bash
docker compose up -d
```

---

## No Space Left on Device

Increase EC2 Root Volume

Then resize filesystem

```bash
sudo growpart /dev/nvme0n1 1

sudo resize2fs /dev/nvme0n1p1
```

---

## Port Already in Use

Find process

```bash
sudo ss -tlnp
```

Kill process

```bash
sudo kill -9 <PID>
```

---

## Backend Cannot Connect to Database

Check

- RDS Security Group
- Database name
- Username
- Password
- JDBC URL
- EC2 can connect to RDS

Test

```bash
nc -zv <RDS-ENDPOINT> 3306
```

---

## Test MySQL Connection

```bash
mysql -h my-rds.c214w64cecep.us-east-1.rds.amazonaws.com \
-u admin \
-p
```

---

# Technologies Used

- React.js
- Spring Boot
- Java 17
- Maven
- MySQL
- AWS RDS
- Docker
- Docker Compose
- Nginx

---

# Ports

| Service | Port |
|----------|------|
| React | 80 |
| Spring Boot | 8080 |
| MySQL (AWS RDS) | 3306 |

---

# Application URLs

ALB URL - http://my-alb-1912724132.us-east-1.elb.amazonaws.com/employees

---

# Deployment Flow

```
Developer

      │

      ▼

Git Clone

      │

      ▼

Configure RDS

      │

      ▼

Update application.properties

      │

      ▼

docker compose build

      │

      ▼

docker compose up -d

      │

      ▼

Frontend (Nginx)

      │

      ▼

Spring Boot

      │

      ▼

AWS RDS
```

---

# Author

**Achal Padol**

AWS | Docker | Spring Boot | React | DevOps
