resource "aws_launch_template" "private_launch_template" {
  name          = var.name_private_launch_template
  image_id      = var.image_id_private_launch_template
  instance_type = var.instance_type_private_launch_template
  vpc_security_group_ids = ["${aws_security_group.sg_private_asg.id}"]

  tags = {
    Name        = "private-launch-template"
    Environment = var.Environment
  }
}

resource "aws_autoscaling_group" "private_asg" {
  name               = var.name_private_asg
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1
  vpc_zone_identifier = [aws_subnet.private_subnet_1a.id, aws_subnet.private_subnet_1b.id, aws_subnet.private_subnet_1c.id] 

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