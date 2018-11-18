terraform {
  required_version = ">= 0.11.8"
}

provider "aws" {
  region = "${var.aws_region}"
}

//module "rds_postgresql" {
//  source = "./modules/rds_postgresql"
//  application = "${var.application}"
//  aws_region = "${var.aws_region}"
//  environment = "${var.environment}"
//  provisioner = "${var.provisioner}"
//}

module "stock_info_service" {
  source      = "./modules/stock_info_service"
  application = "${var.application}"
  aws_region  = "${var.aws_region}"
  environment = "${var.environment}"
  provisioner = "${var.provisioner}"
}
