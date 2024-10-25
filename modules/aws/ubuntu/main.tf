# Create a security group
resource "aws_security_group" "allow_ssh_ping" {
  name        = "allow_ssh_ping_private"
  description = "Allow inbound SSH and ICMP from private IP ranges"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from private IP ranges"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  }

  ingress {
    description = "ICMP from private IP ranges"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow SSH and Ping from Private IPs"
  }
}

# Generate an SSH key pair
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create an AWS key pair
resource "aws_key_pair" "generated_key" {
  key_name   = "ubuntu-server-key"
  public_key = tls_private_key.ssh_key.public_key_openssh
  
  provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.ssh_key.private_key_pem}' > ./ubuntu.pem"
  }
}

# Data source to get the latest Ubuntu 20.04 LTS AMI
data "aws_ssm_parameter" "ubuntu_2004_ami" {
  name = "/aws/service/canonical/ubuntu/server/20.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

# Create an EC2 instance
resource "aws_instance" "ubuntu_server" {
  ami           = data.aws_ssm_parameter.ubuntu_2004_ami.value
  instance_type = "t2.micro"
  key_name      = aws_key_pair.generated_key.key_name

  vpc_security_group_ids = [aws_security_group.allow_ssh_ping.id]
  subnet_id              = var.subnet_id

  tags = {
    Name = "Ubuntu Server"
  }
}
