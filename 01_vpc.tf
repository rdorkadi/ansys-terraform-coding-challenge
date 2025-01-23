resource "aws_vpc" "ansys_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name        = "ansys-vpc"
    Environment = "ansys-coding"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.ansys_vpc.id

  tags = {
    Name        = "ansys-internet-gateway"
    Environment = "ansys-coding"
  }

  depends_on = [aws_vpc.ansys_vpc]
}

