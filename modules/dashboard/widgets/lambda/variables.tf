variable "aws_region" {
  description = "AWS region where resources are located"
  type        = string
}

variable "lambda_functions" {
  description = "List of Lambda function names to monitor"
  type        = list(string)
  default     = []
} 