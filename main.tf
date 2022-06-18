terraform {

  cloud {
    organization = "aaqaishtyaq"
    workspaces {
      name = "container-lab"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.19"
    }
  }

  required_version = ">= 1.2.0"
}


module "aws" {
  source = "./modules/aws"

  instance_name    = var.instance_name
  deployer_pub_key = var.deployer_pub_key
  root_volume_size = var.root_volume_size
}
