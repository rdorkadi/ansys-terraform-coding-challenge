resource "aws_security_group" "sg_public_asg" {
  name        = "public-asg-sg"
  description = "Allow traffic from Load Balancer SG"
  vpc_id      = aws_vpc.ansys_vpc.id
  tags = {
    Name        = "public-asg-sg"
    Environment = "ansys-coding"
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
    Environment = "ansys-coding"
  }
}

resource "aws_vpc_security_group_egress_rule" "public_allow_all" {
  security_group_id = aws_security_group.sg_public_asg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    Name        = "allow-all"
    Environment = "ansys-coding"
  }
}

resource "aws_launch_template" "public_launch_template" {
  name          = var.name_public_launch_template
  image_id      = var.image_id_public_launch_template
  instance_type = var.instance_type_public_launch_template
  vpc_security_group_ids = ["${aws_security_group.sg_public_asg.id}"]
  network_interfaces {
    security_groups = [aws_security_group.sg_public_asg.id]
  }

  tags = {
    Name        = "public-launch-template"
    Environment = "ansys-coding"
  }
}

resource "aws_autoscaling_group" "public_asg" {
  name               = var.name_public_asg
  availability_zones = [var.availability_zone_1a, var.availability_zone_1b, var.availability_zone_1c]
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.public_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "public-asg"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "ansys-coding"
    propagate_at_launch = true
  }
}