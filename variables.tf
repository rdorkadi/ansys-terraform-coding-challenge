variable "region" {
  description = "The region in which the resources will be created."
  default     = "us-east-1"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
  
}

variable "cidr_block_public_subnet_1a" {
  description = "The CIDR block for the public subnet in availability zone 1a."
  default     = "10.0.1.0/24"
}

variable "cidr_block_public_subnet_1b" {
  description = "The CIDR block for the public subnet in availability zone 1b."
  default     = "10.0.2.0/24"
}

variable "cidr_block_public_subnet_1c" {
  description = "The CIDR block for the public subnet in availability zone 1c."
  default     = "10.0.3.0/24"
}

variable "availability_zone_1a" {
  description = "The availability zone for the public subnet in availability zone 1a."
  default     = "us-east-1a"
}

variable "availability_zone_1b" {
  description = "The availability zone for the public subnet in availability zone 1b."
  default     = "us-east-1b"
}

variable "availability_zone_1c" {
  description = "The availability zone for the public subnet in availability zone 1c."
  default     = "us-east-1c"
}

variable "cidr_block_private_subnet_1a" {
  description = "The CIDR block for the private subnet in availability zone 1a."
  default     = "10.0.4.0/24"
}

variable "cidr_block_private_subnet_1b" {
  description = "The CIDR block for the private subnet in availability zone 1b."
  default     = "10.0.5.0/24"
}

variable "cidr_block_private_subnet_1c" {
  description = "The CIDR block for the private subnet in availability zone 1c."
  default     = "10.0.6.0/24"
}

variable "name_public_launch_template" {
  description = "The name of the launch template."
  default     = "public-launch-template"
}

variable "image_id_public_launch_template" {
  description = "The ID of the AMI."
  default     = "ami-0df8c184d5f6ae949"
}

variable "instance_type_public_launch_template" {
  description = "The instance type for the launch template."
  default     = "t2.medium"
}

variable "name_public_asg" {
  description = "The name of the public ASG."
  default     = "public-asg"
}

variable "name_private_launch_template" {
  description = "The name of the launch template."
  default     = "private-launch-template"
}

variable "image_id_private_launch_template" {
  description = "The ID of the AMI."
  default     = "ami-0df8c184d5f6ae949"
}

variable "instance_type_private_launch_template" {
  description = "The instance type for the launch template."
  default     = "t2.micro"
}

variable "name_private_asg" {
  description = "The name of the private ASG."
  default     = "private-asg"
}


