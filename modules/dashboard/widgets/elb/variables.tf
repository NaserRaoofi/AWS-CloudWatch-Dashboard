variable "aws_region" {
  description = "AWS region where resources are located"
  type        = string
}

variable "load_balancers" {
  description = "List of load balancer names to monitor"
  type        = list(string)
  default     = []
} 