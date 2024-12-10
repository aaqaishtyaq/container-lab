
output "instanceId_ec2" {
  description = "ID of the EC2 instance"
  value       = aws_instance.lab1.id
}

output "elasticIP_ec2" {
  description = "Public IP address of the EC2 instance"
  value       = aws_eip.this.public_ip
}
