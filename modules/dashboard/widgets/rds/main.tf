locals {
  rds_metrics = {
    cpu = {
      metric_name = "CPUUtilization"
      stat        = "Average"
      period     = 300
      title      = "CPU Utilization"
    }
    memory = {
      metric_name = "FreeableMemory"
      stat        = "Average"
      period     = 300
      title      = "Freeable Memory"
    }
    storage = {
      metric_name = "FreeStorageSpace"
      stat        = "Average"
      period     = 300
      title      = "Free Storage Space"
    }
    connections = {
      metric_name = "DatabaseConnections"
      stat        = "Average"
      period     = 300
      title      = "Database Connections"
    }
    read_iops = {
      metric_name = "ReadIOPS"
      stat        = "Average"
      period     = 300
      title      = "Read IOPS"
    }
    write_iops = {
      metric_name = "WriteIOPS"
      stat        = "Average"
      period     = 300
      title      = "Write IOPS"
    }
    read_latency = {
      metric_name = "ReadLatency"
      stat        = "Average"
      period     = 300
      title      = "Read Latency"
    }
    write_latency = {
      metric_name = "WriteLatency"
      stat        = "Average"
      period     = 300
      title      = "Write Latency"
    }
  }
}

output "widgets" {
  description = "The RDS dashboard widgets"
  value = flatten([
    for instance in var.rds_instances : [
      for metric_key, metric in local.rds_metrics : {
        type   = "metric"
        width  = 8
        height = 6
        properties = {
          metrics = [
            ["AWS/RDS", metric.metric_name, "DBInstanceIdentifier", instance, { stat = metric.stat, period = metric.period }]
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