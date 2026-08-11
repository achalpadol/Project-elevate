# AWS Three-Tier Architecture – Terraform

## 📌 Project Overview

This project provisions a **three-tier architecture on AWS using Terraform**.

The architecture separates the infrastructure into three logical layers:

* **Web Tier** – Public subnets for internet-facing resources such as an Application Load Balancer.
* **Application Tier** – Private subnets for application servers such as EC2 instances.
* **Database Tier** – Private subnets for Amazon RDS MySQL.

The infrastructure is designed using AWS networking and security best practices, with controlled communication between each tier.

### AWS Services Used

* **Amazon VPC** – Network isolation
* **Amazon EC2** – Application servers
* **Application Load Balancer (ALB)** – Distributes incoming traffic
* **Amazon RDS for MySQL** – Database layer
* **Internet Gateway** – Internet connectivity for public subnets
* **NAT Gateway** – Outbound internet access for private subnets
* **Route Tables** – Network traffic routing
* **Security Groups** – Instance-level traffic control
* **Elastic IP** – Static public IP for NAT Gateway
* **Terraform** – Infrastructure as Code
* **IAM** – AWS permissions and roles

---

# 🏗️ Architecture

```text
                         Internet
                            |
                            v
                  +-------------------+
                  |       ALB         |
                  |    Port 80/443    |
                  +---------+---------+
                            |
                            |
                  ┌─────────┴─────────┐
                  |    WEB TIER       |
                  |   Public Subnets  |
                  |                   |
                  |  ALB / Web Layer  |
                  └─────────┬─────────┘
                            |
                            | HTTP
                            v
                  ┌───────────────────┐
                  |   APP TIER        |
                  |  Private Subnets  |
                  |                   |
                  |  EC2 Instances    |
                  |  Application      |
                  └─────────┬─────────┘
                            |
                            | MySQL :3306
                            v
                  ┌───────────────────┐
                  |   DATABASE TIER   |
                  |  Private Subnets  |
                  |                   |
                  |    RDS MySQL      |
                  └───────────────────┘
```

---

# 📁 Project Structure

```text
THREE-TEIR-ARCHI/
│
├── main.tf
├── variable.tf
├── output.tf
├── terraform.tfvars
│
└── modules/
    │
    ├── VPC/
    │   ├── main.tf
    │   ├── variable.tf
    │   └── output.tf
    │
    ├── SG/
    │   ├── main.tf
    │   ├── variable.tf
    │   └── output.tf
    │
    ├── ALB/
    │   ├── main.tf
    │   ├── variable.tf
    │   └── output.tf
    │
    ├── EC2/
    │   ├── main.tf
    │   ├── variable.tf
    │   └── output.tf
    │
    ├── RDS/
    │   ├── main.tf
    │   ├── variable.tf
    │   └── output.tf
    │
    └── IAM/
        ├── main.tf
        ├── variable.tf
        └── output.tf
```

---

# 1. Prerequisites

Install and configure:

* AWS CLI
* Terraform
* Git
* AWS account
* Appropriate IAM permissions

Configure AWS CLI:

```bash
aws configure
```

Verify the AWS identity:

```bash
aws sts get-caller-identity
```

---

# 2. Terraform Provider

The AWS provider is configured to deploy resources into the selected AWS region.

Example:

```hcl
provider "aws" {
  region = var.region_name
}
```

Example variable:

```hcl
region_name = "us-east-1"
```

---

# 3. VPC

The project creates a dedicated VPC.

Example:

```text
VPC
CIDR: 10.0.0.0/16
```

The VPC contains three logical tiers.

```text
                    VPC
               10.0.0.0/16
                     |
        +------------+------------+
        |            |            |
        v            v            v
     Web Tier     App Tier     DB Tier
     Public       Private      Private
```

---

# 4. Subnet Architecture

The VPC contains multiple subnets distributed across Availability Zones.

```text
VPC
│
├── Public Subnet 1
│   └── us-east-1a
│
├── Public Subnet 2
│   └── us-east-1b
│
├── Private App Subnet 1
│   └── us-east-1a
│
├── Private App Subnet 2
│   └── us-east-1b
│
├── Private DB Subnet 1
│   └── us-east-1a
│
└── Private DB Subnet 2
    └── us-east-1b
```

### Example CIDRs

```text
VPC
10.0.0.0/16

Public Subnets
10.0.1.0/24
10.0.2.0/24

Private Application Subnets
10.0.3.0/24
10.0.4.0/24

Private Database Subnets
10.0.5.0/24
10.0.6.0/24
```

Using multiple Availability Zones provides better availability and fault tolerance.

---

# 5. Internet Gateway

The Internet Gateway provides internet connectivity to resources in the public subnets.

```text
Internet
    |
    v
Internet Gateway
    |
    v
Public Subnets
```

The public route table contains:

```text
Destination: 0.0.0.0/0
Target: Internet Gateway
```

This allows public resources such as the ALB to receive internet traffic.

---

# 6. NAT Gateway

The NAT Gateway is deployed in a public subnet.

Private application instances can use the NAT Gateway for outbound internet access without becoming directly accessible from the internet.

```text
Private App Subnet
        |
        v
Private Route Table
        |
        v
NAT Gateway
        |
        v
Internet Gateway
        |
        v
Internet
```

The NAT Gateway uses an Elastic IP address.

---

# 7. Route Tables

The architecture uses separate route tables for public and private subnets.

## Public Route Table

```text
Destination       Target

10.0.0.0/16       local
0.0.0.0/0         Internet Gateway
```

Associated with:

```text
Public Subnet 1
Public Subnet 2
```

## Private Application Route Table

```text
Destination       Target

10.0.0.0/16       local
0.0.0.0/0         NAT Gateway
```

Associated with:

```text
Private App Subnet 1
Private App Subnet 2
```

## Database Route Table

The database tier remains private and does not require direct internet access.

```text
Destination       Target

10.0.0.0/16       local
```

Associated with:

```text
Private DB Subnet 1
Private DB Subnet 2
```

---

# 8. Security Groups

Three security groups are created for the three tiers.

```text
                 Internet
                    |
                    v
              +----------+
              | ALB-SG   |
              +----+-----+
                   |
                   v
              +----------+
              | APP-SG   |
              +----+-----+
                   |
                   v
              +----------+
              |  DB-SG   |
              +----------+
```

---

# 9. ALB Security Group

The ALB security group allows public HTTP/HTTPS traffic.

Example:

```text
Inbound:

HTTP   : 80
Source : 0.0.0.0/0

HTTPS  : 443
Source : 0.0.0.0/0
```

Outbound traffic can be allowed to the application layer.

```text
Outbound:

Protocol : All
Destination : 0.0.0.0/0
```

---

# 10. Application Security Group

The application security group is attached to the EC2 instances.

Instead of allowing traffic from the entire internet, application traffic is allowed only from the ALB security group.

Example:

```text
Inbound:

Port     : 80
Protocol : TCP
Source   : ALB Security Group
```

This creates controlled communication:

```text
Internet
   |
   v
ALB
   |
   | Port 80
   v
EC2
```

The EC2 instances are not directly exposed to the internet.

---

# 11. Database Security Group

The database security group allows MySQL traffic only from the application security group.

```text
Inbound:

Port     : 3306
Protocol : TCP
Source   : Application Security Group
```

Therefore:

```text
Internet
    X
    |
    X
   RDS

EC2
 |
 | 3306
 v
RDS
```

The database cannot be accessed directly from the internet.

---

# 12. Application Load Balancer

The Application Load Balancer is deployed into the public subnets.

```text
Internet
    |
    v
+-------------+
|     ALB     |
|   Port 80   |
+------+------+
       |
       v
Target Group
       |
       v
EC2 Instances
```

The ALB provides:

* Public access
* Traffic distribution
* Health checks
* High availability across Availability Zones

---

# 13. ALB Target Group

The target group contains the application EC2 instances.

Example:

```text
Target Type: instance
Protocol: HTTP
Port: 80
```

The ALB forwards incoming requests to healthy EC2 instances.

```text
Client
  |
  v
ALB
  |
  +-------> EC2-1
  |
  +-------> EC2-2
```

If one instance becomes unhealthy, the ALB can stop sending traffic to that instance.

---

# 14. EC2 Application Tier

The application servers are deployed in private application subnets.

```text
Private App Subnet 1
        |
        +---- EC2-1
        |
        +---- Application


Private App Subnet 2
        |
        +---- EC2-2
        |
        +---- Application
```

The EC2 instances do not require public IP addresses.

Traffic reaches them through the ALB.

---

# 15. Amazon RDS MySQL

Amazon RDS provides the database layer.

The RDS instance is deployed into private database subnets.

```text
Private DB Subnet 1
        |
        +---- RDS


Private DB Subnet 2
        |
        +---- RDS Subnet Group
```

Example configuration:

```hcl
engine                  = "mysql"
engine_version          = "8.0"
instance_class          = "db.t3.micro"
allocated_storage       = 20
storage_type            = "gp2"
db_name                 = "mydatabase"
username                = "admin"
publicly_accessible     = false
skip_final_snapshot     = true
```

The RDS instance is not publicly accessible.

---

# 16. RDS Subnet Group

The RDS subnet group contains private database subnets.

Example:

```text
RDS Subnet Group
│
├── Private DB Subnet 1
│   └── us-east-1a
│
└── Private DB Subnet 2
    └── us-east-1b
```

This allows RDS to use multiple Availability Zones.

---

# 17. Three-Tier Traffic Flow

The complete traffic flow is:

```text
                    INTERNET
                       |
                       | HTTP/HTTPS
                       v
              +----------------+
              |      ALB       |
              |  Public Subnet |
              +-------+--------+
                      |
                      | HTTP
                      v
              +----------------+
              |      EC2       |
              |  Private App   |
              |     Subnet     |
              +-------+--------+
                      |
                      | MySQL :3306
                      v
              +----------------+
              |      RDS       |
              |     MySQL      |
              |  Private DB    |
              |     Subnet     |
              +----------------+
```

---

# 18. Terraform Modules

The project is organized using reusable Terraform modules.

```text
Root Module
    |
    +---- VPC Module
    |
    +---- Security Group Module
    |
    +---- ALB Module
    |
    +---- EC2 Module
    |
    +---- RDS Module
    |
    +---- IAM Module
```

This makes the infrastructure easier to maintain and reuse.

---

# 19. VPC Module

The VPC module is responsible for:

* VPC
* Public subnets
* Private application subnets
* Private database subnets
* Internet Gateway
* NAT Gateway
* Elastic IP
* Public route tables
* Private route tables
* Route table associations

Example:

```hcl
module "vpc" {
  source = "./modules/VPC"

  vpc_cidr = var.vpc_cidr

  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  db_subnet_cidrs      = var.db_subnet_cidrs

  azs = var.azs
}
```

---

# 20. Security Group Module

The Security Group module creates security groups for:

```text
ALB
Application
Database
```

Communication is restricted to the required layers.

```text
Internet
   |
   v
ALB-SG
   |
   v
APP-SG
   |
   v
DB-SG
```

---

# 21. ALB Module

The ALB module creates:

* Application Load Balancer
* Target Group
* Listener
* Target Group attachments

Example:

```text
ALB
 |
 +---- Listener :80
 |
 +---- Target Group
          |
          +---- EC2
          |
          +---- EC2
```

---

# 22. EC2 Module

The EC2 module creates the application instances.

Example resources:

```text
aws_instance
```

The instances are placed in private application subnets.

The ALB forwards application traffic to these instances.

---

# 23. RDS Module

The RDS module creates:

* RDS subnet group
* RDS MySQL instance
* Database configuration
* Database security group association

The database remains private.

```text
Application EC2
      |
      | 3306
      v
RDS MySQL
```

---

# 24. IAM Module

IAM resources can be created to provide AWS permissions to EC2 or other AWS resources when required.

For example:

```text
IAM Role
   |
   v
IAM Policy
   |
   v
EC2 Instance Profile
```

Only the required permissions should be granted.

---

# 25. Terraform Variables

Example `terraform.tfvars`:

```hcl
region_name = "us-east-1"

vpc_cidr = "10.0.0.0/16"

enable_dns_support   = true
enable_dns_hostnames = true

vpc_name = "three-tier-vpc"

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]

db_subnet_cidrs = [
  "10.0.5.0/24",
  "10.0.6.0/24"
]

azs = [
  "us-east-1a",
  "us-east-1b"
]
```

---

# 26. Terraform Deployment

Navigate to the Terraform root directory:

```bash
cd TERRAFORM/THREE-TEIR-ARCHI
```

Initialize Terraform:

```bash
terraform init
```

Validate the configuration:

```bash
terraform validate
```

Format Terraform files:

```bash
terraform fmt -recursive
```

Create an execution plan:

```bash
terraform plan
```

Deploy the infrastructure:

```bash
terraform apply
```

Enter:

```text
yes
```

Terraform will create the AWS infrastructure.

---

# 27. Verify VPC

After deployment, verify the VPC:

```text
VPC
 |
 +-- Internet Gateway
 |
 +-- Public Subnets
 |
 +-- Private Application Subnets
 |
 +-- Private Database Subnets
 |
 +-- Route Tables
 |
 +-- NAT Gateway
```

---

# 28. Verify ALB

Check the ALB:

```bash
aws elbv2 describe-load-balancers \
  --region us-east-1 \
  --query "LoadBalancers[*].DNSName"
```

Example:

```text
three-tier-alb-123456.us-east-1.elb.amazonaws.com
```

Open the ALB DNS name in a browser.

```text
http://three-tier-alb-123456.us-east-1.elb.amazonaws.com
```

---

# 29. Verify Target Health

Check whether the EC2 instances registered with the target group are healthy.

```bash
aws elbv2 describe-target-health \
  --target-group-arn <TARGET-GROUP-ARN> \
  --region us-east-1
```

Expected status:

```text
healthy
```

Traffic flow:

```text
ALB
 |
 +---- EC2-1 → healthy
 |
 +---- EC2-2 → healthy
```

---

# 30. Database Connectivity

The application EC2 instances communicate with RDS using the RDS endpoint.

Example:

```text
RDS Endpoint:
my-rds.xxxxxxxxx.us-east-1.rds.amazonaws.com
```

Application connection:

```text
EC2
 |
 | MySQL :3306
 v
RDS MySQL
```

The database is accessible only from the application security group.

---

# 31. Security Architecture

The project follows a layered security model.

```text
                INTERNET
                   |
                   v
              +---------+
              |  ALB SG |
              +----+----+
                   |
                   v
              +---------+
              |  APP SG |
              +----+----+
                   |
                   v
              +---------+
              |  DB SG  |
              +---------+
```

### Access Rules

| Layer       | Port | Source                     |
| ----------- | ---: | -------------------------- |
| ALB         |   80 | Internet                   |
| ALB         |  443 | Internet                   |
| Application |   80 | ALB Security Group         |
| Database    | 3306 | Application Security Group |

This prevents direct internet access to the application and database layers.

---

# 32. High Availability

The architecture uses multiple Availability Zones.

```text
                 VPC
                  |
        +---------+---------+
        |                   |
        v                   v
    AZ-1a                 AZ-1b
      |                      |
      |                      |
  Public Subnet          Public Subnet
      |                      |
      +-------- ALB --------+
               |
       +-------+-------+
       |               |
       v               v
   App Subnet       App Subnet
     EC2-1            EC2-2
       |               |
       +-------+-------+
               |
             RDS
```

Using multiple Availability Zones improves availability and reduces the impact of an Availability Zone failure.

---

# 33. Why Three-Tier Architecture?

The main advantage is separation of responsibilities.

### Web Tier

Handles incoming traffic.

```text
ALB
```

### Application Tier

Runs application/business logic.

```text
EC2
```

### Database Tier

Stores application data.

```text
RDS MySQL
```

Each tier can be secured and scaled independently.

---

# 34. Final Architecture

```text
                         INTERNET
                            |
                            v
                 +--------------------+
                 |        ALB         |
                 |    Public Subnets  |
                 |      :80/:443      |
                 +---------+----------+
                           |
                           |
                    ┌──────┴──────┐
                    |   WEB TIER  |
                    | Public      |
                    | Subnets     |
                    └──────┬──────┘
                           |
                           | HTTP
                           v
              ┌─────────────────────────┐
              |       APP TIER           |
              |    Private Subnets       |
              |                          |
              |    EC2 Instance 1        |
              |    EC2 Instance 2        |
              └────────────┬────────────┘
                           |
                           | MySQL :3306
                           v
              ┌─────────────────────────┐
              |      DATABASE TIER       |
              |     Private Subnets      |
              |                          |
              |       RDS MySQL           |
              └─────────────────────────┘
```

---

# 35. Final Result

The Terraform project creates a complete AWS three-tier infrastructure consisting of:

```text
                    AWS VPC
                       |
        +--------------+--------------+
        |              |              |
        v              v              v
    Web Tier       App Tier       DB Tier
        |              |              |
      ALB            EC2            RDS
        |              |              |
    Public          Private        Private
    Subnets         Subnets        Subnets
```

The final request flow is:

```text
User
 |
 | HTTP/HTTPS
 v
Application Load Balancer
 |
 | HTTP
 v
EC2 Application Servers
 |
 | MySQL :3306
 v
Amazon RDS MySQL
```

The project demonstrates how to build a **secure, highly available, and modular three-tier AWS architecture using Terraform**, with public-facing resources isolated from private application and database resources.

---

# 36. Cleanup

To remove the infrastructure created by Terraform:

```bash
terraform destroy
```

Review the resources carefully and enter:

```text
yes
```

> **Warning:** `terraform destroy` permanently removes the Terraform-managed infrastructure. Take special care with RDS and any resources containing important data.
