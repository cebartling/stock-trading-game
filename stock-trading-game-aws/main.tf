terraform {
  required_version = ">= 0.11.8"
}

provider "aws" {
  region  = "${var.aws_region}"
  profile = "${var.aws_named_profile}"
  version = "~> 1.46"
}

######################################################################################################################
## Variables used across all modules
######################################################################################################################
locals {
  production_availability_zones = [
    "us-east-1a",
    "us-east-1b",
  ]
}

//module "networking" {
//  source      = "./modules/networking"
//  environment = "production"
//  vpc_cidr    = "10.0.0.0/16"
//
//  public_subnets_cidr = [
//    "10.0.1.0/24",
//    "10.0.2.0/24",
//  ]
//
//  private_subnets_cidr = [
//    "10.0.10.0/24",
//    "10.0.20.0/24",
//  ]
//
//  region             = "${var.aws_region}"
//  availability_zones = "${local.production_availability_zones}"
//  key_name           = "production_key"
//}


//module "stock_info_service" {
//  source      = "./modules/stock_info_service"
//  application = "${var.application}"
//  aws_region  = "${var.aws_region}"
//  environment = "${var.environment}"
//  provisioner = "${var.provisioner}"
//}


//module "worker_lambda" {
//  source = "./modules/worker_lambda"
//  environment = "production"
//  aws_ecs_cluster_name = "${module.ecs.aws_ecs_cluster_name}"
//  worker_task_definition_arn = "${module.ecs.worker_task_definition_arn}"
//  workflow_queue_url = "${module.workflow_queue.workflow_queue_url}"
//  private_subnets_id = "${module.networking.private_subnets_id}"
//  workflow_bucket_arn = "${module.s3.workflow_bucket_arn}"
//}


//module "workflow_queue" {
//  source = "./modules/workflow_queue"
//  environment = "production"
//}


//module "ecs" {
//  source = "./modules/ecs"
//  environment = "production"
//  vpc_id = "${module.networking.vpc_id}"
//  availability_zones = "${local.production_availability_zones}"
//  repository_name = "worker-pattern-spike/production"
//  subnets_ids = [
//    "${module.networking.private_subnets_id}"
//  ]
//  public_subnet_ids = [
//    "${module.networking.public_subnets_id}"
//  ]
//  security_groups_ids = [
//    "${module.networking.security_groups_ids}"
//  ]
//  workflow_queue_url = "${module.workflow_queue.workflow_queue_url}"
//  aws_region = "${var.aws_region}"
//}


//module "rds_postgresql" {
//  source = "./modules/rds_postgresql"
//  application = "${var.application}"
//  aws_region = "${var.aws_region}"
//  environment = "${var.environment}"
//  provisioner = "${var.provisioner}"
//}


//module "api_gateway" {
//  source = "./modules/api_gateway"
//  environment = "production"
//  workflow_lambda_function_arn = "${module.worker_lambda.workflow_lambda_function_arn}"
//  workflow_lambda_function_invoke_arn = "${module.worker_lambda.workflow_lambda_function_invoke_arn}"
//}


//module "s3" {
//  source = "./modules/s3"
//  environment = "production"
//  aws_bucket = "${var.aws_bucket}"
//}

