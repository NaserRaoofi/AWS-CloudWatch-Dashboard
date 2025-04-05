# AWS CloudWatch Dashboard Terraform Module

[![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A professional-grade Terraform module for creating comprehensive AWS CloudWatch dashboards with advanced analytics, cost optimization, and intelligent monitoring capabilities.

## 🌟 Features

- **Multi-Service Monitoring**
  - EC2 instances performance and health
  - S3 buckets storage and operations
  - VPC network metrics and health
  - RDS database metrics (optional)
  - Lambda functions (optional)
  - Application Load Balancers (optional)

- **Advanced Analytics**
  - Resource efficiency scoring
  - Cost optimization analysis
  - Performance trending
  - Network health analysis
  - Cross-service correlation

- **Cost-Efficient Design**
  - Metric math for advanced calculations
  - Standard CloudWatch metrics
  - Optimized API usage
  - Configurable refresh periods

## 📋 Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform >= 1.0.0
- AWS provider ~> 5.0
- PowerShell (Windows) or Bash (Linux/macOS)

## 🚀 Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/AWS-CloudWatch-Dashboard.git
   cd AWS-CloudWatch-Dashboard
   ```

2. **Initialize Terraform**
   ```bash
   terraform init
   ```

3. **Deploy using the script**
   ```bash
   ./deploy.sh
   ```

## 📊 Dashboard Components

### EC2 Monitoring
- CPU Utilization
- Network I/O
- Disk Operations
- Status Checks
- Resource Efficiency Score

### S3 Analytics
- Bucket Size Tracking
- Object Count
- Storage Trends

### VPC Insights
- Network Traffic
- Packet Analysis
- Health Scoring
- Performance Metrics

### Advanced Analytics
- Anomaly Detection
- Cost Efficiency Metrics
- Resource Utilization
- Performance Scoring

## ⚙️ Configuration

### Basic Configuration (terraform.tfvars)
```hcl
# Basic Configuration
team_name      = "developers"
dashboard_name = "monitoring-dashboard"
aws_region     = "eu-west-2"
environment    = "prod"

# Resource Configuration
ec2_instances = ["i-0123456789abcdef0"]
s3_buckets    = ["my-bucket-name"]
vpc_ids       = ["vpc-0123456789abcdef0"]
```

### Advanced Analytics Configuration
```hcl
# Analytics Settings
enable_advanced_analytics = true
enable_cost_analysis     = true
monthly_budget          = 1000

# Performance Thresholds
performance_thresholds = {
  cpu_critical    = 90
  memory_critical = 85
  network_critical = 80
}
```

## 🛠️ Deployment Options

### Basic Deployment
```bash
./deploy.sh
```

### Environment-Specific Deployment
```bash
./deploy.sh --environment prod --team-name devops
```

### Custom Configuration
```bash
./deploy.sh \
  --environment prod \
  --team-name devops \
  --dashboard-name production \
  --region us-west-2 \
  --monthly-budget 5000
```

## 💰 Cost Considerations

- First 3 dashboards per month: FREE
- Additional dashboards: $3.00 per dashboard per month
- Standard CloudWatch metrics: FREE
- GetMetricData API calls: $0.01 per 1,000 metrics
- No additional costs for metric math calculations

## 🔒 Security

- Uses AWS IAM for access control
- Supports resource tagging
- Environment-based isolation
- Secure metric data handling

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- AWS CloudWatch Documentation
- Terraform AWS Provider
- Community Contributors

## 📞 Support

For support and questions, please open an issue in the GitHub repository.

---
Made with ❤️ by Naser Raoofi 
