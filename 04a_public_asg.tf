resource "aws_launch_template" "public_launch_template" {
  name          = var.name_public_launch_template
  image_id      = var.image_id_public_launch_template
  instance_type = var.instance_type_public_launch_template
  vpc_security_group_ids = ["${aws_security_group.sg_public_asg.id}"]

  tags = {
    Name        = "public-launch-template"
    Environment = var.Environment
  }
}

resource "aws_autoscaling_group" "public_asg" {
  name               = var.name_public_asg
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1

  vpc_zone_identifier = [aws_subnet.public_subnet_1a.id, aws_subnet.public_subnet_1b.id, aws_subnet.public_subnet_1c.id]

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