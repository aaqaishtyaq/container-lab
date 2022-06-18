data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.lab1.id
  allocation_id = aws_eip.this.id
}

resource "aws_eip" "this" {
  vpc      = true
  instance = aws_instance.lab1.id
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.deployer_pub_key
}

resource "aws_instance" "lab1" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.deployer.key_name
  user_data              = file("scripts/install_docker.sh")
  vpc_security_group_ids = [aws_security_group.ec2_ssh_sg.id]
  subnet_id              = aws_subnet.pub_subnet.id

  tags = {
    Name = var.instance_name
  }
}
