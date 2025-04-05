variable "alarms" {
  description = "List of CloudWatch alarms to monitor"
  type = list(object({
    name  = string
    arn   = string
    state = string
  }))
  default = []
}

variable "aws_region" {
  description = "AWS region where the alarms are located"
  type        = string
}

variable "team_name" {
  description = "Name of the team or service"
  type        = string
  default     = ""
} 