locals {
  # Create log widgets for each log group
  log_widgets = flatten([
    for group in var.log_groups : {
      type   = "log"
      width  = 12
      height = 6
      properties = {
        query   = group.filter
        region  = var.aws_region
        title   = "Log Group - ${group.name}"
        view    = "table"
        stacked = false
        limit   = group.limit
        logGroupName = group.name
      }
    }
  ])

  # Create a summary widget showing log group status
  summary_widget = {
    type   = "text"
    width  = 12
    height = 1
    x      = 0
    y      = length(var.log_groups) * 6
    properties = {
      markdown = "## Log Groups Summary\n${join("\n", [for group in var.log_groups : "- ${group.name}"])}"
    }
  }

  # Combine all widgets
  widgets = concat(local.log_widgets, [local.summary_widget])
}

output "widgets" {
  description = "The CloudWatch Logs dashboard widgets"
  value = flatten([
    for group in var.log_groups : {
      type   = "log"
      width  = 12
      height = 6
      properties = {
        query   = group.filter
        region  = var.aws_region
        title   = "Log Group - ${group.name}"
        view    = "table"
        stacked = false
        limit   = group.limit
        logGroupName = group.name
      }
    }
  ])
} 