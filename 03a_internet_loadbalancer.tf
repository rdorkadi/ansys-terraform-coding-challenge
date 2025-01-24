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