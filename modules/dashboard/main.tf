resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.environment}-${var.team_name}-${var.dashboard_name}"
  dashboard_body = jsonencode({
    widgets = flatten(concat(
      var.enable_ec2_monitoring ? module.ec2_widgets.widgets : [],
      var.enable_rds_monitoring ? module.rds_widgets.widgets : [],
      var.enable_s3_monitoring ? module.s3_widgets.widgets : [],
      var.enable_lambda_monitoring ? module.lambda_widgets.widgets : [],
      var.enable_elb_monitoring ? module.elb_widgets.widgets : [],
      var.enable_vpc_monitoring ? module.vpc_widgets.widgets : [],
      var.enable_alarms ? module.alarm_widgets.widgets : [],
      var.enable_logs ? module.log_widgets.widgets : []
    ))
  })
}

# EC2 Widgets Module
module "ec2_widgets" {
  source = "./widgets/ec2"
  aws_region = var.aws_region
  ec2_instances = var.ec2_instances
}

# RDS Widgets Module
module "rds_widgets" {
  source = "./widgets/rds"
  aws_region = var.aws_region
  rds_instances = var.rds_instances
}

# S3 Widgets Module
module "s3_widgets" {
  source = "./widgets/s3"
  aws_region = var.aws_region
  s3_buckets = var.s3_buckets
}

# Lambda Widgets Module
module "lambda_widgets" {
  source = "./widgets/lambda"
  aws_region = var.aws_region
  lambda_functions = var.lambda_functions
}

# ELB Widgets Module
module "elb_widgets" {
  source = "./widgets/elb"
  aws_region = var.aws_region
  load_balancers = var.load_balancers
}

# VPC Widgets Module
module "vpc_widgets" {
  source = "./widgets/vpc"
  aws_region = var.aws_region
  vpc_ids = var.vpc_ids
}

# Alarm Widgets Module
module "alarm_widgets" {
  source = "./widgets/alarms"
  aws_region = var.aws_region
  alarms = var.alarms
}

# Log Widgets Module
module "log_widgets" {
  source = "./widgets/logs"
  aws_region = var.aws_region
  log_groups = var.log_groups
} 