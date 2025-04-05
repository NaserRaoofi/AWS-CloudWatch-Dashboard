variable "aws_region" {
  description = "AWS region where resources are located"
  type        = string
}

variable "ec2_instances" {
  description = "List of EC2 instance IDs to monitor"
  type        = list(string)
  default     = []
}

variable "vpc_ids" {
  description = "List of VPC IDs to monitor"
  type        = list(string)
  default     = []
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