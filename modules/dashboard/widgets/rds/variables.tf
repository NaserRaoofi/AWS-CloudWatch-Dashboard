variable "rds_instances" {
  description = "List of RDS instance identifiers to monitor"
  type        = list(string)
  default     = []
}

variable "aws_region" {
  description = "AWS region where the RDS instances are located"
  type        = string
} 