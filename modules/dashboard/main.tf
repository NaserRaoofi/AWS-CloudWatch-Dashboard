resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.environment}-${var.team_name}-${var.dashboard_name}"
  dashboard_body = jsonencode({
    widgets = flatten(concat(
      # Service-specific widgets
      var.enable_ec2_monitoring ? module.ec2_widgets.widgets : [],
      var.enable_rds_monitoring ? module.rds_widgets.widgets : [],
      var.enable_s3_monitoring ? module.s3_widgets.widgets : [],
      var.enable_lambda_monitoring ? module.lambda_widgets.widgets : [],
      var.enable_elb_monitoring ? module.elb_widgets.widgets : [],
      var.enable_vpc_monitoring ? module.vpc_widgets.widgets : [],
      var.enable_alarms ? module.alarm_widgets.widgets : [],
      var.enable_logs ? module.log_widgets.widgets : [],
      
      # Advanced Analytics widgets
      var.enable_advanced_analytics ? module.analytics_widgets.ec2_analytics_widgets : [],
      var.enable_cost_analysis ? module.analytics_widgets.cost_analysis_widgets : [],
      var.enable_dependency_analysis ? module.analytics_widgets.service_dependency_widgets : [],

      # Dashboard Header
      [
        {
          type = "text"
          width = 24
          height = 2
          properties = {
            markdown = <<-EOT
              # ${title(var.environment)} Environment Dashboard
              **Team:** ${var.team_name} | **Last Updated:** ${timestamp()} | **Environment:** ${var.environment}
              
              This dashboard provides comprehensive monitoring and analytics for AWS resources including advanced metrics, cost analysis, and performance scoring.
            EOT
          }
        }
      ]
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

# Advanced Analytics Module
module "analytics_widgets" {
  source = "./widgets/analytics"
  aws_region = var.aws_region
  ec2_instances = var.ec2_instances
  vpc_ids = var.vpc_ids
  monthly_budget = var.monthly_budget
  enable_anomaly_detection = var.enable_anomaly_detection
  anomaly_detection_config = var.anomaly_detection_config
  performance_thresholds = var.performance_thresholds
} 