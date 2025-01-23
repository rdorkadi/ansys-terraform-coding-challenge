resource "aws_launch_template" "private_launch_template" {
  name   = var.name_private_launch_template
  image_id      = var.image_id_private_launch_template
  instance_type = var.instance_type_private_launch_template

  tags = {
    Name = "private-launch-template"
    Environment = "ansys-coding"
  }
}

resource "aws_autoscaling_group" "private_asg" {
  name = var.name_private_asg
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