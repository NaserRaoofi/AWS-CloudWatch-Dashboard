terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.aws_region
}

# Tags to be applied to all resources
locals {
  common_tags = {
    Project     = "CloudWatch-Dashboard"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Create the CloudWatch Dashboard
module "dashboard" {
  source = "./modules/dashboard"

  team_name     = var.team_name
  dashboard_name = var.dashboard_name
  aws_region    = var.aws_region
  environment   = var.environment
  project_name  = "CloudWatch-Dashboard"

  # Monitoring flags
  enable_ec2_monitoring    = var.enable_ec2_monitoring
  enable_rds_monitoring    = var.enable_rds_monitoring
  enable_s3_monitoring     = var.enable_s3_monitoring
  enable_lambda_monitoring = var.enable_lambda_monitoring
  enable_elb_monitoring    = var.enable_elb_monitoring
  enable_vpc_monitoring    = var.enable_vpc_monitoring
  enable_alarms           = var.enable_alarms
  enable_logs             = var.enable_logs

  # Resources to monitor
  ec2_instances    = var.ec2_instances
  rds_instances    = var.rds_instances
  s3_buckets       = var.s3_buckets
  lambda_functions = var.lambda_functions
  load_balancers   = var.load_balancers
  vpc_ids          = var.vpc_ids
  alarms           = var.alarms
  log_groups       = var.log_groups

  # Tags
  tags = merge(local.common_tags, var.tags)
} 