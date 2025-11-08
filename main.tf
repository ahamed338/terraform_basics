terraform {
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  ebs_optimized = true
  monitoring    = true

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    encrypted = true
  }

  iam_instance_profile = "fake-instance-role"

  tags = {
    Name = "ExampleServer"
  }
}
