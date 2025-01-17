provider "aws" {
  profile = "default"
  region = "us-west-1"
}

#create VPC 
resource "aws_vpc" "my-vpc" {
    cidr_block = var.vpc-cidr
    tags = {
      Name = var.vpc-name
    }
}


#uncomment if you need a private subnet too

/* #create private subnet
resource "aws_subnet" "subnet-private" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.subnet-cidr-private
    tags = {
      Name = "subnet-private"
    }
} */

#create public subnet
resource "aws_subnet" "subnet-public" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.subnet-cidr-public
    tags = {
      Name = "subnet-public"
    }
}

#create internet gateway
resource "aws_internet_gateway" "my-igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name = "my-igw" 
    }
}

#create public route table
resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.my-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-igw.id
    }
    tags = {
      Name = "public-rt"
    }
}

#association on public route table with subnet
resource "aws_route_table_association" "public-rt-ass" {
    subnet_id = aws_subnet.subnet-public.id
    route_table_id = aws_route_table.public-rt.id
}

#uncomment if you need a private subnet too

/* #create private security group
resource "aws_security_group" "ec2-private-sg" {
    vpc_id = aws_vpc.my-vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["10.0.0.0/16"]
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
      Name = "ec2-private-sg"
    }
}
 */

#create public security group
resource "aws_security_group" "ec2-public-sg" {
    vpc_id = aws_vpc.my-vpc.id
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = [var.pc-public-ip]
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
      Name = "ec2-public-sg"
    }
}

#uncomment if you need a private subnet too

/* #create private ec2
resource "aws_instance" "ec2-private" {
    ami = var.ec2-ami
    instance_type = var.ec2-type
    subnet_id = aws_subnet.subnet-private.id
    key_name = "terra"
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.ec2-private-sg.id]
    tags = {
      Name = "private-terra-ec2"
    }
} */

#create public ec2
resource "aws_instance" "ec2-public" {
    ami = var.ec2-ami
    instance_type = var.ec2-type
    subnet_id = aws_subnet.subnet-public.id
    key_name = "terra"
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.ec2-public-sg.id]
    user_data = <<-EOF
                #!/bin/bash
                yum update -y
                yum install -y httpd
                systemctl enable httpd
                systemctl start httpd
                EOF
    tags = {
      Name = "public-terra-ec2"
    }
}

#outputs the public ip of public ec2
output "ec2_public_public_ip" {
  value = aws_instance.ec2-public.public_ip
}
