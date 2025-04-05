variable "aws_region" {
  description = "AWS region where resources are located"
  type        = string
}

variable "vpc_ids" {
  description = "List of VPC IDs to monitor"
  type        = list(string)
  default     = []
} 