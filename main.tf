module "aws" {
  source = "./modules/aws"

  instance_name    = var.instance_name
  deployer_pub_key = var.deployer_pub_key
  root_volume_size = var.root_volume_size
}
