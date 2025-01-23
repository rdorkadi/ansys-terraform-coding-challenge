variable "region" {
  description = "The region in which the resources will be created."
  default     = "us-east-1"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
  
}