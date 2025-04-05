locals {
  elb_metrics = {
    requests = {
      metric_name = "RequestCount"
      stat        = "Sum"
      period     = 300
      title      = "Request Count"
    }
    latency = {
      metric_name = "TargetResponseTime"
      stat        = "Average"
      period     = 300
      title      = "Response Time"
    }
    errors_5xx = {
      metric_name = "HTTPCode_Target_5XX_Count"
      stat        = "Sum"
      period     = 300
      title      = "5XX Errors"
    }
    healthy_hosts = {
      metric_name = "HealthyHostCount"
      stat        = "Average"
      period     = 300
      title      = "Healthy Hosts"
    }
  }
}

output "widgets" {
  description = "The ELB dashboard widgets"
  value = flatten([
    for lb in var.load_balancers : [
      for metric_key, metric in local.elb_metrics : {
        type   = "metric"
        width  = 8
        height = 6
        properties = {
          metrics = [
            ["AWS/ApplicationELB", metric.metric_name, "LoadBalancer", lb, { stat = metric.stat, period = metric.period }]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "${metric.title} - ${lb}"
          period  = metric.period
        }
      }
    ]
  ])
} 