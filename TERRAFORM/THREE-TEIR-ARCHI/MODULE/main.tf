# Generate private key
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create AWS Key Pair using generated public key
resource "aws_key_pair" "deployer" {
  key_name   = "terraform-key"
  public_key = tls_private_key.example.public_key_openssh
}

# Save private key locally
resource "local_file" "private_key" {
  content  = tls_private_key.example.private_key_pem
  filename = "terraform-key.pem"
}

resource "aws_instance" "app" {

  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_app_subnet_id
  vpc_security_group_ids = [var.app_security_group_id]

 key_name = aws_key_pair.deployer.key_name

  associate_public_ip_address = false
  iam_instance_profile = var.iam_instance_profile
  user_data = <<-EOF

#!/bin/bash
yum update -y

amazon-linux-extras install docker -y

systemctl enable docker
systemctl start docker

curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
-o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

usermod -aG docker ec2-user

mkdir /home/ec2-user/app

cd /home/ec2-user/app

docker network create app-network
EOF

  tags = {
    Name = var.instance_name
  }

  depends_on = [aws_key_pair.deployer]
}