variable "team_name" {
  description = "Name of the team or service"
  type        = string
  default     = ""
}

variable "aws_region" {
  description = "AWS region where the EC2 instances are located"
  type        = string
}

variable "ec2_instances" {
  description = "List of EC2 instance IDs to monitor"
  type        = list(string)
  default     = []
} 