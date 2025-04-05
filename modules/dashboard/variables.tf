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

variable "enable_advanced_analytics" {
  description = "Enable advanced analytics widgets"
  type        = bool
  default     = true
}

variable "enable_cost_analysis" {
  description = "Enable cost analysis widgets"
  type        = bool
  default     = true
}

variable "enable_dependency_analysis" {
  description = "Enable service dependency analysis widgets"
  type        = bool
  default     = true
}

variable "monthly_budget" {
  description = "Monthly budget threshold for cost analysis"
  type        = number
  default     = 1000
}

variable "enable_anomaly_detection" {
  description = "Enable anomaly detection for metrics"
  type        = bool
  default     = true
}

variable "anomaly_detection_config" {
  description = "Configuration for anomaly detection"
  type = object({
    standard_deviation_threshold = number
    evaluation_periods         = number
  })
  default = {
    standard_deviation_threshold = 2
    evaluation_periods         = 3
  }
}

variable "performance_thresholds" {
  description = "Thresholds for performance scoring"
  type = object({
    cpu_critical    = number
    memory_critical = number
    network_critical = number
  })
  default = {
    cpu_critical    = 90
    memory_critical = 85
    network_critical = 80
  }
} 