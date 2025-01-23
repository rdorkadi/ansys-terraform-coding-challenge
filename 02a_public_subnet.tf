resource "aws_subnet" "public_subnet_1a" {
  vpc_id     = aws_vpc.ansys_vpc.id
  cidr_block = var.cidr_block_public_subnet_1a
  availability_zone = var.availability_zone_public_subnet_1a

  tags = {
    Name = "ansys-subnet-1a"
    Environment = "ansys-coding"
  }
}

resource "aws_subnet" "public_subnet_1b" {
  vpc_id     = aws_vpc.ansys_vpc.id
  cidr_block = var.cidr_block_public_subnet_1b
  availability_zone = var.availability_zone_public_subnet_1b

  tags = {
    Name = "ansys-subnet-1b"
    Environment = "ansys-coding"    
  }
}

resource "aws_subnet" "public_subnet_1c" {
  vpc_id     = aws_vpc.ansys_vpc.id
  cidr_block = var.cidr_block_public_subnet_1c
  availability_zone = var.availability_zone_public_subnet_1c

  tags = {
    Name = "ansys-subnet-1c"
    Environment = "ansys-coding"
  }
}