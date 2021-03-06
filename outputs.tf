output "instanceId_ec2" {
  description = "ID of the EC2 instance"
  value       = module.aws.instanceId_ec2
}

output "elasticIP_ec2" {
  description = "Public IP address of the EC2 instance"
  value       = module.aws.elasticIP_ec2
}
