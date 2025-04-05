variable "aws_region" {
  description = "AWS region where resources are located"
  type        = string
}

variable "s3_buckets" {
  description = "List of S3 bucket names to monitor"
  type        = list(string)
  default     = []
} 