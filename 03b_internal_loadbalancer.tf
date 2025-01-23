resource "aws_security_group" "private_lb_sg" {
  name        = var.private_lb_sg
  description = "Allow inbound traffic from the public ASG and all outbound traffic"
  vpc_id      = aws_vpc.ansys_vpc.id

  tags = {
    Name        = "private-lb-sg"
    Environment = "ansys-coding"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_public_asg_sg" {
  security_group_id            = aws_security_group.private_lb_sg.id
  from_port = 0
  to_port = 0
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.sg_public_asg.id

  tags = {
    Name        = "allow-http"
    Environment = "ansys-coding"
  }
}

resource "aws_vpc_security_group_egress_rule" "internal_lb_allow_all" {
  security_group_id = aws_security_group.private_lb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    Name        = "allow-all"
    Environment = "ansys-coding"
  }
}

resource "aws_lb" "private_loadbalancer" {
  name               = var.name_private_loadbalancer
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.private_lb_sg.id]
  subnets            = [aws_subnet.private_subnet_1a.id, aws_subnet.private_subnet_1b.id, aws_subnet.private_subnet_1c.id]

  tags = {
    Name        = "private-loadbalancer"
    Environment = "ansys-coding"
  }
}