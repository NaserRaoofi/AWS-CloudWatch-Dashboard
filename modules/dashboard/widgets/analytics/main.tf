locals {
  # Advanced metric calculations using metric math
  metric_math = {
    # EC2 Resource Efficiency Score (0-100)
    ec2_efficiency = {
      expression  = "100 - (m1 + FILL(m2, 0)) / 2"  # Average of CPU and Status Check
      label      = "Resource Efficiency Score"
      id         = "e1"
    }
    
    # EC2 Health Score (0-100)
    ec2_health = {
      expression  = "100 - (m3 * 100)"  # Convert status check (0/1) to percentage
      label      = "Instance Health Score"
      id         = "h1"
    }

    # Network Performance Score
    network_performance = {
      expression  = "(m4 + m5) / PERIOD(m4)"  # Network throughput per second
      label      = "Network Throughput (bytes/s)"
      id         = "n1"
    }

    # Cost Efficiency ($/resource usage)
    cost_efficiency = {
      expression  = "m6 / (m1 + 1)"  # Cost per CPU utilization
      label      = "Cost per CPU Unit"
      id         = "c1"
    }

    # VPC Health Score
    vpc_health = {
      expression  = "100 - (m7 / (m8 + 1) * 100)"  # Dropped packets ratio
      label      = "VPC Health Score"
      id         = "v1"
    }
  }
}

# Resource Analytics Widgets
output "resource_analytics_widgets" {
  description = "Resource analytics widgets using metric math"
  value = flatten([
    for instance in var.ec2_instances : [
      {
        type   = "metric"
        width  = 12
        height = 8
        properties = {
          metrics = [
            # Base metrics
            ["AWS/EC2", "CPUUtilization", "InstanceId", instance, { id = "m1", stat = "Average" }],
            ["AWS/EC2", "StatusCheckFailed", "InstanceId", instance, { id = "m2", stat = "Maximum" }],
            ["AWS/EC2", "StatusCheckFailed_System", "InstanceId", instance, { id = "m3", stat = "Maximum" }],
            ["AWS/EC2", "NetworkIn", "InstanceId", instance, { id = "m4", stat = "Sum" }],
            ["AWS/EC2", "NetworkOut", "InstanceId", instance, { id = "m5", stat = "Sum" }],
            # Derived metrics using math
            [{ expression = local.metric_math.ec2_efficiency.expression, label = local.metric_math.ec2_efficiency.label, id = local.metric_math.ec2_efficiency.id }],
            [{ expression = local.metric_math.ec2_health.expression, label = local.metric_math.ec2_health.label, id = local.metric_math.ec2_health.id }],
            [{ expression = local.metric_math.network_performance.expression, label = local.metric_math.network_performance.label, id = local.metric_math.network_performance.id }]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "Resource Analytics - ${instance}"
          period  = 300
          yAxis = {
            left = {
              min = 0
              max = 100
            }
          }
        }
      }
    ]
  ])
}

# Cost Analytics Widgets
output "cost_analytics_widgets" {
  description = "Cost analytics widgets using metric math"
  value = flatten([
    {
      type   = "metric"
      width  = 24
      height = 6
      properties = {
        metrics = [
          # Base metrics
          ["AWS/Billing", "EstimatedCharges", "ServiceName", "AmazonEC2", { id = "m6", stat = "Maximum", period = 86400 }],
          ["AWS/EC2", "CPUUtilization", "InstanceId", "*", { id = "m1", stat = "Average" }],
          # Cost efficiency metric
          [{ expression = local.metric_math.cost_efficiency.expression, label = local.metric_math.cost_efficiency.label, id = local.metric_math.cost_efficiency.id }]
        ]
        view    = "timeSeries"
        stacked = false
        region  = "us-east-1"  # Billing metrics are in us-east-1
        title   = "Cost Efficiency Analysis"
        period  = 86400
      }
    }
  ])
}

# Network Analytics Widgets
output "network_analytics_widgets" {
  description = "Network analytics widgets using metric math"
  value = flatten([
    for vpc in var.vpc_ids : [
      {
        type   = "metric"
        width  = 12
        height = 6
        properties = {
          metrics = [
            # Base metrics
            ["AWS/VPC", "PacketsDropped", "VpcId", vpc, { id = "m7", stat = "Sum" }],
            ["AWS/VPC", "PacketsTransmitted", "VpcId", vpc, { id = "m8", stat = "Sum" }],
            # VPC health score using metric math
            [{ expression = local.metric_math.vpc_health.expression, label = local.metric_math.vpc_health.label, id = local.metric_math.vpc_health.id }]
          ]
          view    = "timeSeries"
          stacked = false
          region  = var.aws_region
          title   = "Network Health Analysis - ${vpc}"
          period  = 300
          yAxis = {
            left = {
              min = 0
              max = 100
            }
          }
        }
      }
    ]
  ])
} 