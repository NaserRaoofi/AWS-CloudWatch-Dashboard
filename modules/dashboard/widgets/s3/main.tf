locals {
  s3_metrics = {
    bytes = {
      metric_name = "BucketSizeBytes"
      stat        = "Average"
      period     = 86400
      title      = "Bucket Size (Bytes)"
    }
    objects = {
      metric_name = "NumberOfObjects"
      stat        = "Average"
      period     = 86400
      title      = "Number of Objects"
    }
  }
}

output "widgets" {
  description = "The S3 dashboard widgets"
  value = flatten([
    for bucket in var.s3_buckets : [
      for metric_key, metric in local.s3_metrics : {
        type   = "metric"
        width  = 12
        height = 6
        properties = {
          metrics = [
            ["AWS/S3", metric.metric_name, "BucketName", bucket, { stat = metric.stat, period = metric.period }]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "${metric.title} - ${bucket}"
          period  = metric.period
        }
      }
    ]
  ])
} 