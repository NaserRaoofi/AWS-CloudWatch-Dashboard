locals {
  ec2_metrics = {
    cpu = {
      metric_name = "CPUUtilization"
      stat        = "Average"
      period     = 300
      title      = "CPU Utilization"
    }
    network_in = {
      metric_name = "NetworkIn"
      stat        = "Average"
      period     = 300
      title      = "Network In"
    }
    network_out = {
      metric_name = "NetworkOut"
      stat        = "Average"
      period     = 300
      title      = "Network Out"
    }
    disk_read = {
      metric_name = "DiskReadOps"
      stat        = "Average"
      period     = 300
      title      = "Disk Read Ops"
    }
    disk_write = {
      metric_name = "DiskWriteOps"
      stat        = "Average"
      period     = 300
      title      = "Disk Write Ops"
    }
    status = {
      metric_name = "StatusCheckFailed"
      stat        = "Maximum"
      period     = 300
      title      = "Status Check Failed"
    }
  }
}

output "widgets" {
  description = "The EC2 dashboard widgets"
  value = flatten([
    for instance in var.ec2_instances : [
      for metric_key, metric in local.ec2_metrics : {
        type   = "metric"
        width  = 8
        height = 6
        properties = {
          metrics = [
            ["AWS/EC2", metric.metric_name, "InstanceId", instance, { stat = metric.stat, period = metric.period }]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "${metric.title} - ${instance}"
          period  = metric.period
        }
      }
    ]
  ])
} 