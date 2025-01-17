# AWS Infrastructure Automation using Terraform

This repository provides Terraform configuration files and a Bash script to automate the creation and initialization of an AWS infrastructure environment.
- `main.tf` -- Terraform configuration file
- `variables.tf` -- Terraform variables file used by configuration file
- `script.sh` -- Bash script that initialize Terraform, creates infrastructure, and automatically connects to the EC2 machine using SSH.

## Features

### Terraform Configuration
- Creates a **VPC** with a customizable CIDR block.
- Sets up a **public subnet** and an **Internet Gateway**.
- Configures a **public route table** and associates it with the public subnet.
- Deploys a **public EC2 instance** with:
  - User data script to configure an Apache web server.
  - SSH access restricted to a specified public IP.
  - Outputs the public IP of the EC2 instance.

### Variables for Customization
The `variables.tf` file allows customization of:
- CIDR blocks for the VPC and subnets.
- AMI ID and instance type for EC2.
- Public IP for SSH access.

### Initialization Script
- Automates Terraform initialization and applies the configuration.
- Prompts the user to SSH into the deployed EC2 instance after provisioning.

### Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/install) installed locally.
- AWS CLI configured with a valid profile.
- Make sure you have the SSH key saved in your project directory
- Make sure you added your PC's public IP address as pc-public-ip variable in variables.tf file

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/ariguada/simple-aws-deployment.git
   cd simple-aws-deployment
   sudo chmod +x script.sh

2. When everthing is ready, run the bash script:
    ```bash
    sudo ./script.sh
