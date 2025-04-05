#!/bin/bash

# Get current region
REGION=$(aws configure get region)
echo "🔍 Listing AWS resources in region: $REGION"

# List EC2 instances
echo -e "\n🖥️ EC2 Instances:"
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,State.Name,Tags[?Key==`Name`].Value|[0]]' --output table

# List RDS instances
echo -e "\n🗄️ RDS Instances:"
aws rds describe-db-instances --query 'DBInstances[*].[DBInstanceIdentifier,DBInstanceStatus]' --output table

# List S3 buckets
echo -e "\n📦 S3 Buckets:"
aws s3 ls

# List Lambda functions
echo -e "\nλ Lambda Functions:"
aws lambda list-functions --query 'Functions[*].[FunctionName,Runtime]' --output table

# List Load Balancers
echo -e "\n⚖️ Load Balancers:"
aws elbv2 describe-load-balancers --query 'LoadBalancers[*].[LoadBalancerName,Type]' --output table

# List VPCs
echo -e "\n🌐 VPCs:"
aws ec2 describe-vpcs --query 'Vpcs[*].[VpcId,IsDefault,CidrBlock]' --output table

echo -e "\n📝 Note: Use these resource names/IDs when configuring the dashboard"
echo "Current AWS Region: $REGION"
echo "To change region, use: aws configure set region <region-name>" 