resource "aws_vpc" "ansys_vpc" {
  cidr_block       = var.cidr_block
  tags = {
    Name = "ansys-vpc"
    Environment = "ansys-coding"
  }
}

