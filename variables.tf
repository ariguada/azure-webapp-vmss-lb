variable "vpc-cidr" {
  description = "Value for the CIDR for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc-name" {
  description = "Value for the name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "subnet-cidr-private" {
  description = "Value for the CIDR for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet-cidr-public" {
  description = "Value for the CIDR for the subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "igw-name" {
  description = "Name for the Internet GW"
  type        = string
  default     = "my-igw"
}

variable "ec2-ami" {
  description = "AMI for EC2"
  type        = string
  default     = "ami-0cf4e1fcfd8494d5b"
}

variable "ec2-private-name" {
  description = "Name for the private EC2 instance"
  type        = string
  default     = "ec2-private"
}

variable "ec2-public-name" {
  description = "Name for the public EC2 instance"
  type        = string
  default     = "ec2-public"
}

variable "ec2-type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "pc-public-ip" {
  description = "Your Machine Public IP"
  type = string
  default = "YOUR-PUBLIC-IP-ADDRESS"
}
