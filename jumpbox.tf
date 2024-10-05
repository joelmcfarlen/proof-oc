// EC2 Instance
resource "aws_instance" "jumpbox_instance_proof_oc" {
  ami           = var.jumpbox_ami_id_proof_oc
  instance_type = var.jumpbox_instance_type_proof_oc
  subnet_id     = aws_subnet.public_2_proof_oc.id
  vpc_security_group_ids = [aws_security_group.jumpbox_sg_proof_oc.id]
  key_name               = var.jumpbox_ssh_key_proof_oc

  tags = {
    "Name"              = "jumpbox-${var.project_name}"
  }

// Storage
  root_block_device {
    volume_size = var.jumpbox_volume_proof_oc
    volume_type = "gp3"
  }
}

//EIP
resource "aws_eip" "jumpbopx_eip_proof_oc" {
  domain = "vpc"
  instance = aws_instance.jumpbox_instance_proof_oc.id

  depends_on                = [aws_internet_gateway.igw_proof_oc]

  tags = {
    "Name"              = "jumpbox-eip-${var.project_name}"
  }
}

// Security Group
resource "aws_security_group" "jumpbox_sg_proof_oc" {
  vpc_id = aws_vpc.vpc_proof_oc.id

  dynamic "ingress" {
    for_each = var.allowed_ssh_cidr_blocks_proof_oc
    content {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.private_1_proof_oc]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.private_2_proof_oc]
  }

  tags = {
    "Name"              = "jumpbox-sg-${var.project_name}"
  }
}

// IAM Role
resource "aws_iam_role" "jumpbox_role_proof_oc" {
  name = "${var.project_name}-jumpbox-role"

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

// IAM Policy for S3 Access
resource "aws_iam_role_policy" "s3_access_policy" {
  name   = "s3-access-policy-${var.project_name}"
  role   = aws_iam_role.jumpbox_role_proof_oc.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject"
        ]
        Resource = "arn:aws:s3:::logs/*"
      }
    ]
  })
}

// IAM Instance Profile
resource "aws_iam_instance_profile" "s3_logging_instance_profile" {
  name = "instance-profile-${var.project_name}"
  role = aws_iam_role.jumpbox_role_proof_oc.name
}

