// ALB
resource "aws_lb" "alb_proof_oc" {
  name               = "alb-${var.project_name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg_proof_oc.id]
  subnets            = [aws_subnet.public_1_proof_oc.id, aws_subnet.public_2_proof_oc.id]
}

// ALB Listener
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb_proof_oc.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

// Target Group
resource "aws_lb_target_group" "alb_target_group" {
  name        = "alb-target-group"
  port        = 443
  protocol    = "HTTPS"
  vpc_id      = aws_vpc.vpc_proof_oc.id

  health_check {
    protocol = "HTTPS"
    path     = "/"
    port     = "443"
  }

  tags = {
    "Project" = var.project_name
    "Name"    = "alb-target-group-${var.project_name}"
  }
}

// ALB SG
resource "aws_security_group" "alb_sg_proof_oc" {
  vpc_id = aws_vpc.vpc_proof_oc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Project" = var.project_name
    "Name"      = "alb-sg-${var.project_name}"
  }
}
