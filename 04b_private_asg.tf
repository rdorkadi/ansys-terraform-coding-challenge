resource "aws_security_group" "sg_private_asg" {
  name        = "private-asg-sg"
  description = "Allow traffic from Internal Load Balancer SG"
  vpc_id      = aws_vpc.ansys_vpc.id
  tags = {
    Name        = "private-asg-sg"
    Environment = "ansys-coding"
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
    Environment = "ansys-coding"
  }
}

resource "aws_vpc_security_group_egress_rule" "private_allow_all" {
  security_group_id = aws_security_group.sg_private_asg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    Name        = "allow-all"
    Environment = "ansys-coding"
  }
}

resource "aws_launch_template" "private_launch_template" {
  name          = var.name_private_launch_template
  image_id      = var.image_id_private_launch_template
  instance_type = var.instance_type_private_launch_template
  vpc_security_group_ids = ["${aws_security_group.sg_private_asg.id}"]
  network_interfaces {
    security_groups = [aws_security_group.sg_private_asg.id]
  }
  


  tags = {
    Name        = "private-launch-template"
    Environment = "ansys-coding"
  }
}

resource "aws_autoscaling_group" "private_asg" {
  name               = var.name_private_asg
  availability_zones = [var.availability_zone_1a, var.availability_zone_1b, var.availability_zone_1c]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.private_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "private-asg"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "ansys-coding"
    propagate_at_launch = true
  }
}