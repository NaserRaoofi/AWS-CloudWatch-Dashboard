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

# Default analytics settings
ENABLE_ADVANCED_ANALYTICS=true
ENABLE_COST_ANALYSIS=true
ENABLE_DEPENDENCY_ANALYSIS=true
MONTHLY_BUDGET=1000

# Default resources
EC2_INSTANCES='["i-0e8a91dc94b7c6def"]'
S3_BUCKETS='["aws-cloudtrail-logs-235494806851-596e1256"]'
VPC_IDS='["vpc-04254083ab36d8a5e"]'

# Default analytics configuration
ANOMALY_DETECTION_THRESHOLD=2
ANOMALY_EVALUATION_PERIODS=3
CPU_CRITICAL_THRESHOLD=90
MEMORY_CRITICAL_THRESHOLD=85
NETWORK_CRITICAL_THRESHOLD=80

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --environment)
            ENVIRONMENT="$2"
            shift 2
            ;;
        --team-name)
            TEAM_NAME="$2"
            shift 2
            ;;
        --dashboard-name)
            DASHBOARD_NAME="$2"
            shift 2
            ;;
        --region)
            AWS_REGION="$2"
            shift 2
            ;;
        --disable-analytics)
            ENABLE_ADVANCED_ANALYTICS=false
            ENABLE_COST_ANALYSIS=false
            ENABLE_DEPENDENCY_ANALYSIS=false
            shift
            ;;
        --monthly-budget)
            MONTHLY_BUDGET="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

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

# Analytics Configuration
enable_advanced_analytics = $ENABLE_ADVANCED_ANALYTICS
enable_cost_analysis = $ENABLE_COST_ANALYSIS
enable_dependency_analysis = $ENABLE_DEPENDENCY_ANALYSIS
monthly_budget = $MONTHLY_BUDGET

# Analytics Thresholds
anomaly_detection_config = {
  standard_deviation_threshold = $ANOMALY_DETECTION_THRESHOLD
  evaluation_periods         = $ANOMALY_EVALUATION_PERIODS
}

performance_thresholds = {
  cpu_critical    = $CPU_CRITICAL_THRESHOLD
  memory_critical = $MEMORY_CRITICAL_THRESHOLD
  network_critical = $NETWORK_CRITICAL_THRESHOLD
}

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

# Print configuration summary
echo -e "\n📊 Dashboard Configuration Summary:"
echo "Environment: $ENVIRONMENT"
echo "Team Name: $TEAM_NAME"
echo "Dashboard Name: $DASHBOARD_NAME"
echo "Region: $AWS_REGION"
echo -e "\n📈 Analytics Configuration:"
echo "Advanced Analytics: $ENABLE_ADVANCED_ANALYTICS"
echo "Cost Analysis: $ENABLE_COST_ANALYSIS"
echo "Dependency Analysis: $ENABLE_DEPENDENCY_ANALYSIS"
echo "Monthly Budget: $MONTHLY_BUDGET"

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

# Print dashboard access information
echo -e "\n🔗 Dashboard Access:"
echo "You can access your dashboard at:"
echo "https://$AWS_REGION.console.aws.amazon.com/cloudwatch/home?region=$AWS_REGION#dashboards:name=$ENVIRONMENT-$TEAM_NAME-$DASHBOARD_NAME" 