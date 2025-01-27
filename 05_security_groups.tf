resource "aws_security_group" "public_lb_sg" {
  name        = var.name_public_lb_sg
  description = "Allow HTTP inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.ansys_vpc.id

  tags = {
    Name        = "public-lb-sg"
    Environment = var.Environment
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
    Environment = var.Environment
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.public_lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    Name        = "allow-all"
    Environment = var.Environment
  }
}

resource "aws_security_group" "private_lb_sg" {
  name        = var.private_lb_sg
  description = "Allow inbound traffic from the public ASG and all outbound traffic"
  vpc_id      = aws_vpc.ansys_vpc.id

  tags = {
    Name        = "private-lb-sg"
    Environment = var.Environment
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_public_asg_sg" {
  security_group_id            = aws_security_group.private_lb_sg.id
  from_port                    = 0
  to_port       = 0
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.sg_public_asg.id

  tags = {
    Name        = "allow-http"
    Environment = var.Environment
  }
}

resource "aws_vpc_security_group_egress_rule" "internal_lb_allow_all" {
  security_group_id = aws_security_group.private_lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    Name        = "allow-all"
    Environment = var.Environment
  }
}

resource "aws_security_group" "sg_public_asg" {
  name        = "public-asg-sg"
  description = "Allow traffic from Load Balancer SG"
  vpc_id      = aws_vpc.ansys_vpc.id
  tags = {
    Name        = "public-asg-sg"
    Environment = var.Environment
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_public_lb" {
  security_group_id            = aws_security_group.sg_public_asg.id
  referenced_security_group_id = aws_security_group.public_lb_sg.id
  from_port                    = 0
  ip_protocol                  = "tcp"
  to_port                      = 0

  tags = {
    Name        = "allow-public-lb"
    Environment = var.Environment
  }
}

resource "aws_vpc_security_group_egress_rule" "public_allow_all" {
  security_group_id = aws_security_group.sg_public_asg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    Name        = "allow-all"
    Environment = var.Environment
  }
}

resource "aws_security_group" "sg_private_asg" {
  name        = var.sg_private_asg
  description = "Allow traffic from Internal Load Balancer SG"
  vpc_id      = aws_vpc.ansys_vpc.id
  tags = {
    Name        = "private-asg-sg"
    Environment = var.Environment
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_private_lb" {
  security_group_id            = aws_security_group.sg_private_asg.id
  referenced_security_group_id = aws_security_group.private_lb_sg.id
  from_port = 0
  ip_protocol = "tcp"
  to_port = 0

  tags = {
    Name        = "allow-private-lb"
    Environment = var.Environment
  }
}

resource "aws_vpc_security_group_egress_rule" "private_allow_all" {
  security_group_id = aws_security_group.sg_private_asg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    Name        = "allow-all"
    Environment = var.Environment
  }
}



