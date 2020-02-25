#!/bin/bash

STACK_NAME=awsgoodparts
REGION=us-east-1
CLI_PROFILE=aws-good-parts

EC2_INSTANCE_TYPE=t2.micro

# Deploy the CloudFormation template
echo -e "\n\n============== Deploying main.cloudformation.yml =============="
aws cloudformation deploy \
  --region $REGION \
  --profile $CLI_PROFILE \
  --stack-name $STACK_NAME \
  --template-file main.cloudformation.yml \
  --no-fail-on-empty-changeset \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    EC2InstanceType=$EC2_INSTANCE_TYPE \

# If the deploy succeeded, show the DNS nae of the created instance
if [ $? -eq 0 ]; then
  aws cloudformation list-exports \
    --profile aws-good-parts
    --query "Exports[?Name=='InstanceEndpoint'].Value"
fi
