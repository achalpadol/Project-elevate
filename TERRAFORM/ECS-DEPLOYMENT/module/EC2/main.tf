# Generate private key
resource "tls_private_key" "this_example" {
  algorithm = var.KEY_ALGORITHM
  rsa_bits  = var.RSA_BITS
}
# Create AWS Key Pair using generated public key
resource "aws_key_pair" "this_deployer" {
  key_name   = var.KEY_NAME
  public_key = tls_private_key.this_example.public_key_openssh
}
# Save private key locally
resource "local_file" "this_private_key" {
  content  = tls_private_key.this_example.private_key_pem
  filename = var.PRIVATE_KEY_FILENAME
}
resource "aws_instance" "this_app" {
  ami                         = var.AMI_ID
  instance_type               = var.INSTANCE_TYPE
  subnet_id                   = var.PRIVATE_APP_SUBNET_ID
  vpc_security_group_ids      = [var.APP_SECURITY_GROUP_ID]
  key_name                    = aws_key_pair.this_deployer.key_name
  associate_public_ip_address = false
  iam_instance_profile        = var.IAM_INSTANCE_PROFILE
  user_data                   = <<-EOF
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
    Name = var.INSTANCE_NAME
  }
  depends_on = [aws_key_pair.this_deployer]
}