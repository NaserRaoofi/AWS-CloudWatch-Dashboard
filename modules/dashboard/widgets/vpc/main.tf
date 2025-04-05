locals {
  vpc_metrics = {
    packets = {
      metric_name = "PacketsTransmitted"
      stat        = "Sum"
      period     = 300
      title      = "Packets Transmitted"
    }
    bytes = {
      metric_name = "BytesTransmitted"
      stat        = "Sum"
      period     = 300
      title      = "Bytes Transmitted"
    }
    dropped = {
      metric_name = "DroppedPackets"
      stat        = "Sum"
      period     = 300
      title      = "Dropped Packets"
    }
  }
}

output "widgets" {
  description = "The VPC dashboard widgets"
  value = flatten([
    for vpc in var.vpc_ids : [
      for metric_key, metric in local.vpc_metrics : {
        type   = "metric"
        width  = 8
        height = 6
        properties = {
          metrics = [
            ["AWS/VPC", metric.metric_name, "VpcId", vpc, { stat = metric.stat, period = metric.period }]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "${metric.title} - ${vpc}"
          period  = metric.period
        }
      }
    ]
  ])
} 