#!/bin/bash

echo "Searching for VPC with public subnet..."
read -r subnet_id vpc_id <<< $(aws ec2 describe-subnets \
            --filters "Name=map-public-ip-on-launch,Values=true" \
            --query "Subnets[*].[SubnetId,VpcId]" \
            --output "text" \
            | head -n 1)

echo "Found public subnet: $subnet_id"
echo "Found subnet's VPC:  $vpc_id"

echo 
echo "Creating new security group for web server:"
sg_id=$(aws ec2 create-security-group \dgvcecho "Searching for VPC with public subnet..."
read -r subnet_id vpc_id <<< $(aws ec2 describe-subnets \
            --filters "Name=map-public-ip-on-launch,Values=true" \
            --query "Subnets[*].[SubnetId,VpcId]" \
            --output "text" \
            | head -n 1)

echo "Found public subnet: $subnet_id"
echo "Found subnet's VPC:  $vpc_id"cvFgF''giigoooooooooooon /n;bn,n,    
 dff
        --group-name "webserver-sg" \
        --description "Web server security group" \
        --vpc-id $vpc_id \
        --output "text")

sg_id=$(aws ec2 describe-security-groups \
        --group-name "webserver-sg" \
        --query "SecurityGroups[*].GroupId" \
        --output "text")

echo "New security group ID: $sg_id"
echo

echo "Allowing SSH and HTTP traffic in web server security group:"
aws ec2 authorize-security-group-ingress \
    --group-id $sg_id \
    --protocol "tcp" \
    --port 80 \
    --cidr "0.0.0.0/0" \
    --output "text" > /dev/null

aws ec2 authorize-security-group-ingress \
    --group-id $sg_id \
     --protocol "tcp" \
     --port 22 \
     --cidr "0.0.0.0/0" \
     --output "text" > /dev/null
echo "$sg_id now allows HTTP traffic on port 80 and SSH on port 22 from 0.0.0.0/0"
echo


#aws ec2 describe-security-groups
echo "Launching EC2 instance and setting up server..."
instance_id=$(aws ec2 run-instances \
    --image-id resolve:ssm:/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2 \
    --instance-type "t3.micro" \
    --count 1 \
    --key-name "vockey" \
    --subnet-id $subnet_id \
    --security-group-ids $sg_id \
    --associate-public-ip-address \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=Web-Server}]" \
    --user-data file://server.sh \
    --query "Instances[*].[InstanceId]" \
    --output "text")

#echo $instance_id
#aws ec2 wait instance-status-ok --instance-ids $instance_id
sleep 25

read -r instance_id pub_ip <<< $(aws ec2 describe-instances \
    --filters "Name=instance-state-name,Values=running" \
    --query "Reservations[*].Instances[*].[InstanceId, PublicIpAddress]" \
    --output text)

echo "Instance $instance_id was created with Public IP $pub_ip and an HTTP server listening on port 80"


#Delete terminate instance and delete security group for cleanup
#aws ec2 terminate-instances --instance-ids $instance_id
#aws ec2 delete-security-group --group-id $sg_id