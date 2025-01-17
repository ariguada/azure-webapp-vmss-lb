#!/bin/bash

# Exit immediately if error happens
set -e

# Navigate to your project directory
cd /mnt/c/Users/Your-User/Desktop/projects/terraform/

# Initialize Terraform and Apply configuration
terraform init
terraform apply -auto-approve

# Retrieve the public IP of the EC2 instance from Terraform output
INSTANCE_IP=$(terraform output -raw ec2_public_public_ip)

# Initialize variables for tracking user attempts
attempts=0
max_attempts=3

# Loop to prompt the user for SSH connection up to a maximum number of attempts
while [[ $attempts -lt $max_attempts ]]; do
    # Prompt the user for input
    read -p "Do you want to SSH to the EC2 instance? Type 'yes' to continue, 'no' to cancel: " user_input
    
    # Check if the user typed 'yes'
    if [[ "$user_input" == "yes" ]]; then
        sleep 0.5
        echo "Connecting via SSH..."
        sleep 1
        # Connect to the EC2 instance via SSH using the specified key
        sudo ssh -i /mnt/c/Users/Your-User/Desktop/projects/terraform/terra.pem ec2-user@$INSTANCE_IP
exit 0
    # Check if the user typed 'no'
    elif [[ "$user_input" == "no" ]]; then
        sleep 0.5
        echo "Exiting script..."
        sleep 1
        exit 1
    # Handle invalid input
    else
        # Increment the attempts counter
        attempts=$((attempts + 1))
        sleep 0.5
        # If maximum attempts reached, display an error message and exit
        if [[ $attempts -eq $max_attempts ]]; then
            echo "Wrong input. Exiting script..."
            exit 1
        else
            # Prompt the user again if attempts are still available
            echo "Wrong input. Please type 'yes' or 'no'."
        fi
    fi
done
