module "test_dashboard" {
  source = "../../modules/dashboard"

  # Required variables
  team_name      = "test-team"
  dashboard_name = "test-dashboard"
  aws_region     = "us-east-1"

  # Optional variables with defaults
  environment = "dev"
  project_name = "test-project"

  # Monitoring flags
  enable_ec2_monitoring     = true
  enable_rds_monitoring     = true
  enable_s3_monitoring      = true
  enable_lambda_monitoring  = true
  enable_elb_monitoring     = true
  enable_vpc_monitoring     = true
  enable_alarms            = true
  enable_logs             = true

  # Resource lists
  rds_instances = [
    "test-db-1",
    "test-db-2"
  ]

  s3_buckets = [
    "test-bucket-1",
    "test-bucket-2"
  ]

  lambda_functions = [
    "test-function-1",
    "test-function-2"
  ]

  load_balancers = [
    "test-lb-1",
    "test-lb-2"
  ]

  vpc_ids = [
    "vpc-12345678",
    "vpc-87654321"
  ]

  alarms = [
    {
      name  = "test-alarm-1"
      arn   = "arn:aws:cloudwatch:us-east-1:123456789012:alarm:test-alarm-1"
      state = "OK"
    },
    {
      name  = "test-alarm-2"
      arn   = "arn:aws:cloudwatch:us-east-1:123456789012:alarm:test-alarm-2"
      state = "ALARM"
    }
  ]

  log_groups = [
    {
      name   = "/aws/lambda/test-function-1"
      filter = "@message like 'error'"
      limit  = 100
    },
    {
      name   = "/aws/vpc/test-vpc"
      filter = "@message like 'rejected'"
      limit  = 50
    }
  ]

  # Tags
  tags = {
    Test = "true"
    Owner = "test-team"
  }
}

# Output the dashboard URL
output "dashboard_url" {
  value = "https://console.aws.amazon.com/cloudwatch/home?region=${module.test_dashboard.aws_region}#dashboards:name=${module.test_dashboard.dashboard_name}"
} 