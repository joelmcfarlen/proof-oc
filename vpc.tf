// VPC
resource "aws_vpc" "vpc_proof_oc" {
  cidr_block       = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-${var.project_name}"
  }
}


// IG
resource "aws_internet_gateway" "igw_proof_oc" {
  vpc_id = aws_vpc.vpc_proof_oc.id

  tags = {
    "Project" = var.project_name
    "Name"    = "igw-${var.project_name}"
  }
}


// Subnets
resource "aws_subnet" "public_1_proof_oc" {
  vpc_id                  = aws_vpc.vpc_proof_oc.id
  cidr_block              = var.public_1_proof_oc
  availability_zone       = var.az1_proof_oc
  map_public_ip_on_launch = true

  tags = {
    "Project" = var.project_name
    "Name"    = "public-subnet-1-${var.project_name}"
  }
}

resource "aws_subnet" "public_2_proof_oc" {
  vpc_id                  = aws_vpc.vpc_proof_oc.id
  cidr_block              = var.public_1_proof_oc
  availability_zone       = var.az2_proof_oc
  map_public_ip_on_launch = true

  tags = {
    "Project" = var.project_name
    "Name"    = "public-subnet-2-${var.project_name}"
  }
}

resource "aws_subnet" "private_1_proof_oc" {
  vpc_id            = aws_vpc.vpc_proof_oc.id
  cidr_block        = var.private_1_proof_oc
  availability_zone = var.az1_proof_oc

  tags = {
    "Project" = var.project_name
    "Name"    = "private-subnet-1-${var.project_name}"
  }
}

resource "aws_subnet" "private_2_proof_oc" {
  vpc_id            = aws_vpc.vpc_proof_oc.id
  cidr_block        = var.private_2_proof_oc
  availability_zone = var.az2_proof_oc

  tags = {
    "Project" = var.project_name
    "Name"    = "private-subnet-2-${var.project_name}"
  }
}


// Route Tables
resource "aws_route" "internet_access_proof_oc" {
  route_table_id         = aws_route_table.public_rt_proof_oc.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_proof_oc.id
}

resource "aws_route_table" "public_rt_proof_oc" {
  vpc_id = aws_vpc.vpc_proof_oc.id

  tags = {
    "Project" = var.project_name
    "Name"    = "public-rt-${var.project_name}"
  }
}

resource "aws_route_table" "private_rt_proof_oc" {
  vpc_id = aws_vpc.vpc_proof_oc.id

  tags = {
    "Project" = var.project_name
    "Name"    = "private-rt-${var.project_name}"
  }
}

resource "aws_route_table_association" "public1_proof_oc" {
  subnet_id      = aws_subnet.public_1_proof_oc.id
  route_table_id = aws_route_table.public_rt_proof_oc.id
}

resource "aws_route_table_association" "public2_proof_oc" {
  subnet_id      = aws_subnet.public_2_proof_oc.id
  route_table_id = aws_route_table.public_rt_proof_oc.id
}

resource "aws_route_table_association" "private1_proof_oc" {
  subnet_id      = aws_subnet.private_1_proof_oc.id
  route_table_id = aws_route_table.private_rt_proof_oc.id
}

resource "aws_route_table_association" "private2_proof_oc" {
  subnet_id      = aws_subnet.private_2_proof_oc.id
  route_table_id = aws_route_table.private_rt_proof_oc.id
}

// Flowlogs
