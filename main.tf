resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("/Users/noorahamed/.ssh/id_rsa.pub")
}


resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    description = "Allow inbound SSH from specific IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["49.207.144.127/32"]
  }

  egress {
    description = "Allow all outbound traffic to specific IP"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["49.207.144.127/32"]
  }
}

resource "null_resource" "example_ec2" {
  triggers = {
    key_pair   = aws_key_pair.deployer.id
    sg         = aws_security_group.allow_ssh.id
    iam_profile = aws_iam_instance_profile.ec2_profile.id
  }

  provisioner "local-exec" {
    command = "echo 'Simulating EC2 instance creation...'"
  }
}

