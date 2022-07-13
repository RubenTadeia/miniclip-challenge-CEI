## 
# Resources

resource "aws_launch_template" "awslinux" {
  name_prefix   = "awslinux"
  image_id      = var.ami_name
  instance_type = "t2.micro"
  vpc_security_group_ids = [module.sg.asg_sg_id]
  user_data = base64encode(file(var.first_script))
  tags = {
        Name = var.server_name
}
}

resource "aws_autoscaling_group" "autosg" {
    name               = var.auto_scaling_group_name
    availability_zones = ["eu-west-1","eu-west-2"]
    desired_capacity   = 2
    max_size           = var.auto_scaling_group_max_inst
    min_size           = var.auto_scaling_group_min_inst

    launch_template {
        id      = aws_launch_template.awslinux.id
        version = "$Latest"
    }
    lifecycle {
        create_before_destroy = true
    }
    health_check_type = "EC2"
    health_check_grace_period = 300
}

resource "aws_autoscaling_policy" "web_cluster_target_tracking_policy" {
    name = "staging-web-cluster-target-tracking-policy"
    policy_type = "TargetTrackingScaling"
    autoscaling_group_name = aws_autoscaling_group.autosg.name
    estimated_instance_warmup = 300

    target_tracking_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ASGAverageCPUUtilization"
        }
            target_value = "80"
        }
}

module "sg" {
    source = "./../sg"
}