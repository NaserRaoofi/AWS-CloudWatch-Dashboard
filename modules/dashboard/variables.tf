variable "team_name" {
  description = "Name of the team or service"
  type        = string
}

variable "dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "CloudWatch-Dashboard"
}

variable "aws_region" {
  description = "AWS region where resources are located"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "enable_ec2_monitoring" {
  description = "Enable EC2 monitoring widgets"
  type        = bool
  default     = true
}

variable "ec2_instances" {
  description = "List of EC2 instance IDs to monitor"
  type        = list(string)
  default     = []
}

variable "enable_rds_monitoring" {
  description = "Enable RDS monitoring widgets"
  type        = bool
  default     = true
}

variable "enable_s3_monitoring" {
  description = "Enable S3 monitoring widgets"
  type        = bool
  default     = true
}

variable "enable_lambda_monitoring" {
  description = "Enable Lambda monitoring widgets"
  type        = bool
  default     = true
}

variable "enable_elb_monitoring" {
  description = "Enable ELB monitoring widgets"
  type        = bool
  default     = true
}

variable "enable_vpc_monitoring" {
  description = "Enable VPC monitoring widgets"
  type        = bool
  default     = true
}

variable "enable_alarms" {
  description = "Enable CloudWatch alarms widgets"
  type        = bool
  default     = false
}

variable "enable_logs" {
  description = "Enable CloudWatch logs widgets"
  type        = bool
  default     = false
}

variable "rds_instances" {
  description = "List of RDS instance identifiers to monitor"
  type        = list(string)
  default     = []
}

variable "s3_buckets" {
  description = "List of S3 bucket names to monitor"
  type        = list(string)
  default     = []
}

variable "lambda_functions" {
  description = "List of Lambda function names to monitor"
  type        = list(string)
  default     = []
}

variable "load_balancers" {
  description = "List of load balancer names to monitor"
  type        = list(string)
  default     = []
}

variable "vpc_ids" {
  description = "List of VPC IDs to monitor"
  type        = list(string)
  default     = []
}

variable "alarms" {
  description = "List of CloudWatch alarms to monitor"
  type = list(object({
    name  = string
    arn   = string
    state = string
  }))
  default = []
}

variable "log_groups" {
  description = "List of CloudWatch log groups to monitor"
  type = list(object({
    name   = string
    filter = string
    limit  = number
  }))
  default = []
} 