#!/bin/bash

# Exit on error
set -e

# Default values
TEAM_NAME="developers"
DASHBOARD_NAME="monitoring-developers"
AWS_REGION="eu-west-2"
ENVIRONMENT="test"

# Default monitoring settings
ENABLE_EC2=true
ENABLE_RDS=false
ENABLE_S3=true
ENABLE_LAMBDA=false
ENABLE_ELB=false
ENABLE_VPC=true
ENABLE_ALARMS=false
ENABLE_LOGS=false

# Default resources
EC2_INSTANCES='["i-0e8a91dc94b7c6def"]'
S3_BUCKETS='["aws-cloudtrail-logs-235494806851-596e1256"]'
VPC_IDS='["vpc-04254083ab36d8a5e"]'

# Generate terraform.tfvars
cat > terraform.tfvars << EOF
# Basic Configuration
team_name = "$TEAM_NAME"
dashboard_name = "$DASHBOARD_NAME"
aws_region = "$AWS_REGION"
environment = "$ENVIRONMENT"

# Monitoring Configuration
enable_ec2_monitoring = $ENABLE_EC2
enable_rds_monitoring = $ENABLE_RDS
enable_s3_monitoring = $ENABLE_S3
enable_lambda_monitoring = $ENABLE_LAMBDA
enable_elb_monitoring = $ENABLE_ELB
enable_vpc_monitoring = $ENABLE_VPC
enable_alarms = $ENABLE_ALARMS
enable_logs = $ENABLE_LOGS

# Resource Configuration
ec2_instances = $EC2_INSTANCES
s3_buckets = $S3_BUCKETS
vpc_ids = $VPC_IDS

# Tags
tags = {
  Environment = "$ENVIRONMENT"
  Project     = "cloudwatch-dashboard"
  ManagedBy   = "terraform"
}
EOF

# Initialize Terraform
echo -e "\n📦 Initializing Terraform..."
terraform init

# Select or create workspace
echo -e "\n🔧 Setting up workspace..."
terraform workspace select "$ENVIRONMENT" || terraform workspace new "$ENVIRONMENT"

# Validate configuration
echo -e "\n✅ Validating configuration..."
terraform validate

# Show execution plan
echo -e "\n📋 Showing execution plan..."
terraform plan -var-file="terraform.tfvars"

# Ask for confirmation
read -p "Do you want to apply these changes? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Deployment cancelled."
    exit 0
fi

# Apply changes
echo -e "\n🔄 Applying changes..."
terraform apply -var-file="terraform.tfvars" -auto-approve

echo -e "\n✅ Deployment completed successfully!" 