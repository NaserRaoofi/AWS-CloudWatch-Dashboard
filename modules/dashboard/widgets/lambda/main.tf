locals {
  lambda_metrics = {
    invocations = {
      metric_name = "Invocations"
      stat        = "Sum"
      period     = 300
      title      = "Invocations"
    }
    errors = {
      metric_name = "Errors"
      stat        = "Sum"
      period     = 300
      title      = "Errors"
    }
    duration = {
      metric_name = "Duration"
      stat        = "Average"
      period     = 300
      title      = "Duration"
    }
    throttles = {
      metric_name = "Throttles"
      stat        = "Sum"
      period     = 300
      title      = "Throttles"
    }
  }
}

output "widgets" {
  description = "The Lambda dashboard widgets"
  value = [
    for func in var.lambda_functions : [
      for metric_key, metric in local.lambda_metrics : {
        type   = "metric"
        width  = 6
        height = 6
        properties = {
          metrics = [
            ["AWS/Lambda", metric.metric_name, "FunctionName", func, { stat = metric.stat, period = metric.period }]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "${metric.title} - ${func}"
          period  = metric.period
        }
      }
    ]
  ]
} 