variable "log_groups" {
  description = "List of CloudWatch log groups to monitor"
  type = list(object({
    name   = string
    filter = string
    limit  = number
  }))
  default = []
}

variable "aws_region" {
  description = "AWS region where the log groups are located"
  type        = string
}

variable "team_name" {
  description = "Name of the team or service"
  type        = string
  default     = ""
} 