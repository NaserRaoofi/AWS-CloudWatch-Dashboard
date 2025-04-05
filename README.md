# AWS CloudWatch Dashboard Terraform Project

This Terraform project creates a modular and production-ready AWS CloudWatch Dashboard with support for multiple AWS services and features.

## Features

- Modular dashboard design per team/service
- Support for multiple AWS services:
  - EC2 monitoring
  - RDS monitoring
  - S3 monitoring
  - Lambda monitoring
  - ELB monitoring
  - VPC monitoring
- Optional alarm support
- Log retention configuration
- Easy reuse across projects and teams

## Project Structure

```
.
├── main.tf                 # Main Terraform configuration
├── variables.tf            # Project-wide variables
├── outputs.tf             # Output definitions
├── modules/
│   └── dashboard/         # Dashboard module
│       ├── main.tf        # Dashboard configuration
│       ├── variables.tf   # Dashboard variables
│       └── widgets/       # Widget modules
│           ├── ec2/       # EC2 widgets
│           ├── rds/       # RDS widgets
│           ├── s3/        # S3 widgets
│           ├── lambda/    # Lambda widgets
│           ├── elb/       # ELB widgets
│           └── vpc/       # VPC widgets
└── examples/              # Example configurations
```

## Usage

1. Clone the repository
2. Configure your AWS credentials
3. Create a `terraform.tfvars` file with your configuration:

```hcl
aws_region = "us-east-1"
environment = "dev"
team_name = "your-team"
dashboard_name = "main-dashboard"
enable_alarms = true
alarm_notification_arn = "arn:aws:sns:region:account-id:topic-name"
```

4. Initialize Terraform:
```bash
terraform init
```

5. Apply the configuration:
```bash
terraform apply
```

## Configuration Options

- `aws_region`: AWS region to deploy resources
- `environment`: Environment name (dev, staging, prod)
- `team_name`: Name of the team or service
- `dashboard_name`: Name of the CloudWatch dashboard
- `enable_ec2_monitoring`: Enable EC2 monitoring widgets
- `enable_rds_monitoring`: Enable RDS monitoring widgets
- `enable_s3_monitoring`: Enable S3 monitoring widgets
- `enable_lambda_monitoring`: Enable Lambda monitoring widgets
- `enable_elb_monitoring`: Enable ELB monitoring widgets
- `enable_vpc_monitoring`: Enable VPC monitoring widgets
- `enable_alarms`: Enable CloudWatch alarms
- `alarm_notification_arn`: ARN of the SNS topic for alarm notifications
- `log_retention_days`: Number of days to retain CloudWatch logs

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details. 