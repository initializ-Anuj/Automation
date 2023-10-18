provider "aws" {
  region = "us-east-1"  # Replace with your desired AWS region
}

resource "aws_instance" "ec2_instance" {
  count         = 1
  ami           = "ami-053b0d53c279acc90"  # Replace with your desired AMI ID
  instance_type = "t3.large"  # Replace with your desired instance type
  key_name      = "crossplane"  # Just the name of the key pair without .pem extension

  user_data = <<-EOT
              #!/bin/bash
              curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" sh -
              EOT

  tags = {
    Name = "single-node-k3s"
  }
}
