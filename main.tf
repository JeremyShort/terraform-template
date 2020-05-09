terraform {
  backend "s3" {
    bucket  = "bucket-for-storing-state"
    key     = "demo-vpc/infrastructure.tfstate"
    region  = "us-east-1"
    encrypt = "true"
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
}

module "jenkins" {
	source = "./modules/jenkins"
}
