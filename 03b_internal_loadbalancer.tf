resource "aws_lb" "private_loadbalancer" {
  name               = var.name_private_loadbalancer
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.private_lb_sg.id]
  subnets            = [aws_subnet.private_subnet_1a.id, aws_subnet.private_subnet_1b.id, aws_subnet.private_subnet_1c.id]

  tags = {
    Name        = "private-loadbalancer"
    Environment = var.Environment
  }
}