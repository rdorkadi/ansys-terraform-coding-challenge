resource "aws_vpc" "ansys_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name        = "ansys-vpc"
    Environment = var.Environment
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.ansys_vpc.id

  tags = {
    Name        = "ansys-internet-gateway"
    Environment = var.Environment
  }

  depends_on = [aws_vpc.ansys_vpc]
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.ansys_vpc.id

  tags = {
    Name = "ansys-public-route-table"
    Environment = var.Environment
  }
}

resource "aws_route" "public_route" {
  route_table_id            = aws_route_table.public_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table_association" "public_subnet_1a_association" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_1b_association" {
  subnet_id      = aws_subnet.public_subnet_1b.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_1c_association" {
  subnet_id      = aws_subnet.public_subnet_1c.id
  route_table_id = aws_route_table.public_route_table.id
}

