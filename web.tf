// Web ASG
resource "aws_autoscaling_group" "asg_proof_oc" {
  name = "asg-${var.project_name}"
  vpc_zone_identifier = [aws_subnet.private_1_proof_oc.id, aws_subnet.private_2_proof_oc.id]
  launch_template {
    id      = aws_launch_template.asg_launch_template_proof_oc.id
    version = "$Latest"
  }

  min_size = 2
  max_size = 6
  desired_capacity = 2

  target_group_arns = [aws_lb_target_group.alb_target_group_proof_oc.arn]

  health_check_type         = "EC2"
  health_check_grace_period = 600
  tag {
    key                 = "Project"
    value               = var.project_name
    propagate_at_launch = true
  }
}


// Web ASG LT
resource "aws_launch_template" "asg_launch_template_proof_oc" {
  name_prefix   = "asg-launch-template-${var.project_name}"
  image_id      = var.web_ami_id_proof_oc
  instance_type = var.web_instance_type_proof_oc

  key_name = var.web_ssh_key_proof_oc

  iam_instance_profile {
    name = aws_iam_instance_profile.asg_instance_profile.name
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.web_volume_proof_oc
      volume_type = "gp3"
    }
  }

    network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.web_instance_sg_proof_oc.id]
  }

    tag_specifications {
    resource_type = "instance"

    tags = {
      Name    = "web-${var.project_name}"
    }
  }

// Web User Data
  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              EOF
            )
}


// Web Instance IAM
resource "aws_iam_role" "asg_ec2_role_proof_oc" {
  name = "asg-ec2-role-${var.project_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}


// Web Instance IAM Attachment
resource "aws_iam_role_policy" "asg_ec2_s3_policy" {
  name   = "s3-policy"
  role   = aws_iam_role.asg_ec2_role_proof_oc.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject"
        ]
        Resource = "arn:aws:s3:::images/*" 
      }
    ]
  })
}


// Web Instance Profile
resource "aws_iam_instance_profile" "asg_instance_profile" {
  name = "asg-instance-profile-${var.project_name}"
  role = aws_iam_role.asg_ec2_role_proof_oc.name
}


// Web Instance SG
resource "aws_security_group" "web_instance_sg_proof_oc" {
  vpc_id = aws_vpc.vpc_proof_oc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg_proof_oc.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.jumpbox_sg_proof_oc.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"    = "asg-instance-sg-${var.project_name}"
  }
}

