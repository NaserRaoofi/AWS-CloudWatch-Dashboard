locals {
  # Group alarms by state
  alarms_by_state = {
    OK = [for alarm in var.alarms : alarm if alarm.state == "OK"]
    ALARM = [for alarm in var.alarms : alarm if alarm.state == "ALARM"]
    INSUFFICIENT_DATA = [for alarm in var.alarms : alarm if alarm.state == "INSUFFICIENT_DATA"]
  }

  # Create widgets for each alarm state
  state_widgets = [
    {
      type   = "alarm"
      width  = 12
      height = 6
      x      = 0
      y      = 0
      properties = {
        title  = "Alarm Status Summary"
        alarms = var.alarms[*].arn
      }
    },
    {
      type   = "text"
      width  = 12
      height = 1
      x      = 0
      y      = 6
      properties = {
        markdown = "## Alarm Counts\n- OK: ${length(local.alarms_by_state.OK)}\n- ALARM: ${length(local.alarms_by_state.ALARM)}\n- INSUFFICIENT_DATA: ${length(local.alarms_by_state.INSUFFICIENT_DATA)}"
      }
    }
  ]

  # Create detailed widgets for each alarm
  alarm_widgets = flatten([
    for alarm in var.alarms : {
      type   = "metric"
      width  = 8
      height = 6
      properties = {
        metrics = [
          ["AWS/CloudWatch", "StateValue", "AlarmName", alarm.name, { stat = "Maximum", period = 300 }]
        ]
        view    = "timeSeries"
        stacked = false
        region  = var.aws_region
        title   = "Alarm State - ${alarm.name}"
        period  = 300
      }
    }
  ])

  # Combine all widgets
  widgets = concat(local.state_widgets, local.alarm_widgets)
}

output "widgets" {
  description = "The CloudWatch Alarms dashboard widgets"
  value = flatten([
    for alarm in var.alarms : {
      type   = "metric"
      width  = 8
      height = 6
      properties = {
        metrics = [
          ["AWS/CloudWatch", "StateValue", "AlarmName", alarm.name, { stat = "Maximum", period = 300 }]
        ]
        view    = "timeSeries"
        stacked = false
        region  = var.aws_region
        title   = "Alarm State - ${alarm.name}"
        period  = 300
      }
    }
  ])
} 