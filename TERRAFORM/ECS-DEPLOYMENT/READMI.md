# Employee Management Application – AWS ECS Deployment

## 📌 Project Overview

This project is a full-stack Employee Management application deployed on AWS using a three-tier architecture.

### Application Stack

* **Frontend:** React.js
* **Web Server:** Nginx
* **Backend:** Spring Boot
* **Database:** MySQL
* **Containerization:** Docker
* **Container Registry:** Amazon ECR Public
* **Container Platform:** Amazon ECS Fargate
* **Load Balancer:** Application Load Balancer (ALB)
* **Database Service:** Amazon RDS for MySQL
* **Networking:** Amazon VPC
* **Logging:** Amazon CloudWatch Logs
* **Infrastructure as Code:** Terraform

---

# 🏗️ Architecture

```text
                         Internet
                            |
                            |
                    +---------------+
                    |      ALB      |
                    | Port 80 / 443 |
                    +-------+-------+
                            |
                            |
                  Public Subnets
                            |
                            |
                 +----------+----------+
                 |                     |
                 |    ECS Fargate      |
                 |                     |
                 |  +---------------+  |
                 |  | React + Nginx |  |
                 |  |   Port 80     |  |
                 |  +-------+-------+  |
                 |          |          |
                 |          | /api     |
                 |          v          |
                 |  +---------------+  |
                 |  | Spring Boot   |  |
                 |  |   Port 8080   |  |
                 |  +-------+-------+  |
                 |          |          |
                 +----------|----------+
                            |
                            |
                     Private Subnets
                            |
                            v
                    +---------------+
                    |  Amazon RDS   |
                    |     MySQL     |
                    |    Port 3306  |
                    +---------------+
```

---

# 📁 Project Structure

```text
ReactJS-Spring-Boot-CRUD-Full-Stack-App/
│
├── react-frontend/
│   ├── src/
│   ├── public/
│   ├── package.json
│   ├── Dockerfile
│   └── nginx.conf
│
├── springboot-backend/
│   ├── src/
│   ├── pom.xml
│   ├── Dockerfile
│   └── src/main/resources/
│       └── application.properties
│
└── TERRAFORM/
    └── THREE-TEIR-ARCHI/
        ├── main.tf
        ├── variable.tf
        ├── output.tf
        ├── terraform.tfvars
        │
        └── modules/
            ├── VPC/
            ├── SG/
            ├── RDS/
            ├── ALB/
            ├── EC2/
            ├── IAM/
            ├── ECS-CLUSTER/
            ├── TASK-DEFINITION/
            └── ECS-SERVICE/
```

---

# 1. Prerequisites

Install/configure:

* AWS CLI
* Docker
* Terraform
* Git
* AWS account
* IAM permissions for required AWS resources

Configure AWS CLI:

```bash
aws configure
```

Verify:

```bash
aws sts get-caller-identity
```

---

# 2. Application Configuration

## Backend Database Configuration

Update the Spring Boot `application.properties` file.

Example:

```properties
spring.datasource.url=jdbc:mysql://RDS-ENDPOINT:3306/mydatabase
spring.datasource.username=admin
spring.datasource.password=YOUR_PASSWORD

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true

server.port=8080
```

Replace:

```text
RDS-ENDPOINT
YOUR_PASSWORD
```

with your actual RDS values.

---

# 3. Build the Spring Boot JAR

Navigate to the backend directory:

```bash
cd springboot-backend
```

Build the application:

```bash
mvn clean package
```

The JAR will be generated inside:

```text
target/
```

Example:

```text
target/app.jar
```

---

# 4. Backend Docker Image

Example backend Dockerfile:

```dockerfile
FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
```

Build:

```bash
docker build -t backend:latest .
```

Test:

```bash
docker images
```

---

# 5. Frontend Docker Image

The React application is served using Nginx.

Example Dockerfile:

```dockerfile
FROM node:16 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build


FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

> If your React project generates `dist` instead of `build`, use `/app/dist`.

---

# 6. Nginx Configuration

Because the frontend and backend containers run inside the **same ECS task**, Nginx forwards `/api` requests to the backend container through localhost.

```nginx
server {
    listen 80;

    server_name localhost;

    root /usr/share/nginx/html;

    index index.html;

    location / {
        try_files $uri /index.html;
    }

    location /api/ {
        proxy_pass http://127.0.0.1:8080/api/;

        proxy_http_version 1.1;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

The browser sends:

```text
http://ALB-DNS/api/employees
```

Nginx forwards it internally:

```text
127.0.0.1:8080/api/employees
```

---

# 7. Build Frontend Image

Navigate to the frontend:

```bash
cd react-frontend
```

Build:

```bash
docker build -t frontend:latest .
```

Verify:

```bash
docker images
```

---

# 8. Amazon ECR

This project uses Amazon ECR Public.

Login:

```bash
aws ecr-public get-login-password --region us-east-1 | \
docker login --username AWS --password-stdin public.ecr.aws
```

---

# 9. Tag Backend Image

Example:

```bash
docker tag backend:latest \
public.ecr.aws/v4c7w1f2/full-stack-repo:backend-v1
```

Push:

```bash
docker push \
public.ecr.aws/v4c7w1f2/full-stack-repo:backend-v1
```

---

# 10. Tag Frontend Image

Use only one `:` before the tag.

Correct:

```bash
docker tag frontend:latest \
public.ecr.aws/v4c7w1f2/full-stack-repo:frontend-v1
```

Push:

```bash
docker push \
public.ecr.aws/v4c7w1f2/full-stack-repo:frontend-v1
```

Incorrect:

```text
full-stack-repo:frontend:v1
```

Correct:

```text
full-stack-repo:frontend-v1
```

---

# 11. Amazon VPC

The Terraform configuration creates:

```text
VPC
│
├── Public Subnet 1
├── Public Subnet 2
│
├── Private App Subnet 1
├── Private App Subnet 2
│
├── Private DB Subnet 1
└── Private DB Subnet 2
```

Additional components:

```text
Internet Gateway
NAT Gateway
Public Route Tables
Private Route Tables
```

---

# 12. Security Groups

Three security groups are used.

## ALB Security Group

Allows:

```text
HTTP  → 80
HTTPS → 443
```

from:

```text
0.0.0.0/0
```

## Application Security Group

Allows application traffic from the ALB.

```text
Port 80
```

## Database Security Group

Allows MySQL traffic:

```text
Port 3306
```

only from the application layer.

---

# 13. Amazon RDS

Create a MySQL RDS instance in the private DB subnets.

Example configuration:

```hcl
DB_SUBNET_GROUP_NAME = "my-db-subnet-group"

DB_IDENTIFIER = "my-rds"

ENGINE = "mysql"

ENGINE_VERSION = "8.0"

INSTANCE_CLASS = "db.t3.micro"

ALLOCATED_STORAGE = 20

STORAGE_TYPE = "gp2"

DB_NAME = "mydatabase"

USERNAME = "admin"

PASSWORD = "YOUR_PASSWORD"

PUBLICLY_ACCESSIBLE = false

SKIP_FINAL_SNAPSHOT = true
```

After deployment, get the RDS endpoint:

```bash
aws rds describe-db-instances \
  --db-instance-identifier my-rds
```

Use the endpoint in the Spring Boot configuration.

---

# 14. Application Load Balancer

The ALB is deployed in the public subnets.

Traffic flow:

```text
Internet
   |
   v
ALB :80
   |
   v
ECS Fargate Task :80
   |
   v
Nginx
   |
   v
Spring Boot :8080
```

The ALB target group must use:

```text
target_type = "ip"
```

because ECS Fargate with:

```text
network_mode = "awsvpc"
```

uses ENI/IP-based networking.

Do **not** use:

```text
target_type = "instance"
```

for this Fargate configuration.

---

# 15. ECS Cluster

Terraform creates the ECS cluster.

Example:

```hcl
CLUSTER_NAME       = "employee-management-cluster"
CONTAINER_INSIGHTS = "enabled"
```

---

# 16. ECS Task Definition

The task definition contains two containers:

```text
ECS Task
│
├── Frontend
│   ├── React
│   ├── Nginx
│   └── Port 80
│
└── Backend
    ├── Spring Boot
    └── Port 8080
```

Example:

```hcl
TASK_FAMILY = "employee-management"

TASK_CPU = 512

TASK_MEMORY = 1024

FRONTEND_CONTAINER_NAME = "frontend"

FRONTEND_IMAGE = "public.ecr.aws/v4c7w1f2/full-stack-repo:frontend-v1"

FRONTEND_CONTAINER_PORT = 80

BACKEND_CONTAINER_NAME = "backend"

BACKEND_IMAGE = "public.ecr.aws/v4c7w1f2/full-stack-repo:backend-v1"

BACKEND_CONTAINER_PORT = 8080

LOG_GROUP_NAME = "/ecs/employee-cluster"
```

---

# 17. CloudWatch Logs

Create a CloudWatch log group:

```text
/ecs/employee-cluster
```

Frontend logs:

```text
frontend
```

Backend logs:

```text
backend
```

The ECS task execution role must have permission to write logs to CloudWatch.

---

# 18. ECS Service

The ECS service maintains the desired number of running tasks.

Example:

```hcl
SERVICE_NAME = "employee-management-service"

DESIRED_COUNT = 1
```

The ECS service uses:

```text
ECS Cluster
      |
      v
Task Definition
      |
      v
Fargate Task
      |
      +---- Frontend :80
      |
      +---- Backend :8080
```

---

# 19. Terraform Deployment

Navigate to the Terraform root directory:

```bash
cd TERRAFORM/THREE-TEIR-ARCHI
```

Initialize Terraform:

```bash
terraform init
```

Validate:

```bash
terraform validate
```

Format:

```bash
terraform fmt -recursive
```

Review:

```bash
terraform plan
```

Deploy:

```bash
terraform apply
```

Enter:

```text
yes
```

---

# 20. Verify ECS

Check the ECS service:

```bash
aws ecs describe-services \
  --cluster employee-management-cluster \
  --services employee-management-service \
  --region us-east-1
```

Check running tasks:

```bash
aws ecs list-tasks \
  --cluster employee-management-cluster \
  --service-name employee-management-service \
  --region us-east-1
```

The task should show:

```text
RUNNING
```

---

# 21. Verify Backend

Inside the ECS task, test the backend:

```bash
curl http://127.0.0.1:8080/api/employees
```

Expected response could be:

```json
[]
```

or employee data.

If this works, the backend is reachable from the frontend container.

---

# 22. Access the Application

Get the ALB DNS:

```bash
aws elbv2 describe-load-balancers \
  --region us-east-1 \
  --query "LoadBalancers[*].DNSName"
```

Example:

```text
employee-alb-123456.us-east-1.elb.amazonaws.com
```

Open:

```text
http://employee-alb-123456.us-east-1.elb.amazonaws.com
```

The request flow is:

```text
Browser
   |
   | HTTP :80
   v
ALB
   |
   | Target Group
   v
ECS Fargate
   |
   v
Frontend/Nginx :80
   |
   | /api/*
   v
Spring Boot :8080
   |
   v
RDS MySQL :3306
```

---

# 23. Employee API

The frontend should call the API using a relative URL:

```javascript
axios.post("/api/employees", data);
```

Do not use:

```javascript
axios.post("http://localhost:8080/api/employees", data);
```

because `localhost` in the browser refers to the user's computer, not the ECS backend.

Using:

```javascript
/api/employees
```

allows the request to go through the ALB and Nginx.

---

# 24. Troubleshooting

## ECS task stops

Check:

```text
ECS
→ Cluster
→ Tasks
→ Stopped
→ Stopped reason
```

Also check CloudWatch logs.

---

## Backend exits with code 143

Exit code `143` generally means the process received:

```text
SIGTERM
```

This can happen when ECS stops/replaces the task.

Check the task events and application logs to determine why ECS initiated the shutdown.

---

## Frontend exits with code 1

Check Nginx logs:

```bash
docker logs <frontend-container>
```

Also verify:

```bash
nginx -t
```

---

## CloudWatch log group does not exist

Create the log group before starting the ECS task:

```bash
aws logs create-log-group \
  --log-group-name /ecs/employee-cluster \
  --region us-east-1
```

---

## Fargate target group error

If you see:

```text
target type instance is incompatible with awsvpc
```

change the target group:

```hcl
target_type = "ip"
```

---

## ALB cannot reach ECS

Verify:

```text
ALB Security Group
        |
        v
ECS Security Group
        |
        v
Port 80
```

Also verify the target group shows:

```text
healthy
```

---

## Frontend cannot reach backend

Check:

```bash
curl http://127.0.0.1:8080/api/employees
```

from the frontend container.

If it fails, investigate the backend container.

If it works, check the Nginx configuration:

```nginx
location /api/ {
    proxy_pass http://127.0.0.1:8080/api/;
}
```

---

# 25. Important Deployment Notes

Whenever you change the frontend code or `nginx.conf`:

```bash
docker build -t frontend:latest .
```

Tag:

```bash
docker tag frontend:latest \
public.ecr.aws/v4c7w1f2/full-stack-repo:frontend-v2
```

Push:

```bash
docker push \
public.ecr.aws/v4c7w1f2/full-stack-repo:frontend-v2
```

Then update the ECS task definition:

```text
frontend-v1
```

to:

```text
frontend-v2
```

and deploy the new task definition.

For backend changes, repeat the same process with:

```text
backend-v2
```

---

# 26. Cleanup

To remove the Terraform infrastructure:

```bash
terraform destroy
```

Review the resources and enter:

```text
yes
```

> Be careful when using `terraform destroy`, especially with RDS and production resources.

---

# ✅ Final Architecture

```text
                    INTERNET
                       |
                       v
              +----------------+
              |      ALB       |
              |      :80       |
              +-------+--------+
                      |
                      v
              +----------------+
              |   ECS FARGATE  |
              |                |
              | +------------+ |
              | | React/Nginx| |
              | |    :80     | |
              | +------+-----+ |
              |        |       |
              |        | /api  |
              |        v       |
              | +------------+ |
              | | Spring Boot| |
              | |    :8080   | |
              | +------+-----+ |
              +--------|-------+
                       |
                       v
              +----------------+
              |   RDS MySQL    |
              |     :3306      |
              +----------------+
```
Output
Access the application through the ALB URL.
<img width="1920" height="1080" alt="Screenshot (69)" src="https://github.com/user-attachments/assets/b5c632da-55b4-42cb-b451-833a7bdcfea4" />
Data is stored in the database successfully.
<img width="1920" height="1080" alt="Screenshot (70)" src="https://github.com/user-attachments/assets/50ae3215-5adc-4a93-9231-584f163e0fcc" />

The application can therefore be accessed through **one ALB DNS**, while Nginx internally routes API requests to the Spring Boot container and Spring Boot communicates with the private RDS database.
