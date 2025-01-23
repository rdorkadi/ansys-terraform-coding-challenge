resource "aws_security_group" "public_lb_sg" {
  name        = var.name_public_lb_sg
  description = "Allow HTTP inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.ansys_vpc.id

  tags = {
    Name        = "public-lb-sg"
    Environment = "ansys-coding"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.public_lb_sg.id
  cidr_ipv4         = aws_vpc.ansys_vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

  tags = {
    Name        = "allow-http"
    Environment = "ansys-coding"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.public_lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    Name        = "allow-all"
    Environment = "ansys-coding"
  }
}

resource "aws_lb" "public_loadbalancer" {
  name               = var.name_public_loadbalancer
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_lb_sg.id]
  subnets            = [aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1b.id, aws_subnet.public_subnet_1c.id]

  tags = {
    Name        = "public-loadbalancer"
    Environment = "ansys-coding"
  }
}