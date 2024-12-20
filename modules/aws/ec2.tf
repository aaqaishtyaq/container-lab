# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   filter {
#     name   = "architecture"
#     values = ["x86_64"]
#   }

#   owners = ["099720109477"] # Canonical
# }

data "aws_ssm_parameter" "ubuntu_24_04_ami" {
  name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.lab1.id
  allocation_id = aws_eip.this.id
}

resource "aws_eip" "this" {
  instance = aws_instance.lab1.id
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.deployer_pub_key
}

resource "aws_instance" "lab1" {
  ami                    = data.aws_ssm_parameter.ubuntu_24_04_ami.value
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.deployer.key_name
  user_data              = file("scripts/install_docker.sh")
  vpc_security_group_ids = [aws_security_group.ec2_ssh_sg.id]
  subnet_id              = aws_subnet.pub_subnet.id

  credit_specification {
    cpu_credits = "standard"
  }

  root_block_device {
    delete_on_termination = true
    volume_size           = 24
  }

  tags = {
    Name = var.instance_name
  }
}
