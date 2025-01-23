resource "aws_subnet" "public_subnet_1a" {
  vpc_id            = aws_vpc.ansys_vpc.id
  cidr_block        = var.cidr_block_public_subnet_1a
  availability_zone = var.availability_zone_1a

  tags = {
    Name        = "ansys-public-subnet-1a"
    Environment = "ansys-coding"
  }
}

resource "aws_subnet" "public_subnet_1b" {
  vpc_id            = aws_vpc.ansys_vpc.id
  cidr_block        = var.cidr_block_public_subnet_1b
  availability_zone = var.availability_zone_1b

  tags = {
    Name        = "ansys-public-subnet-1b"
    Environment = "ansys-coding"
  }
}

resource "aws_subnet" "public_subnet_1c" {
  vpc_id            = aws_vpc.ansys_vpc.id
  cidr_block        = var.cidr_block_public_subnet_1c
  availability_zone = var.availability_zone_1c

  tags = {
    Name        = "ansys-public-subnet-1b"
    Environment = "ansys-coding"
  }
}