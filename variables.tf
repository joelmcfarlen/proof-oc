provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project             = var.project_name
      "Terraform Managed" = "Yes"
    }
  }
}


// Region
variable "region" {
  description = "Deploy region for Project"
  type        = string
}


// VPC
variable "vpc_cidr" {
  description = "CIDR block for the proof-vpc"
  type        = string
}


// Networking
variable "public_1_proof_oc" {
  description = "CIDR block for public subnet 1 for Proof OC"
  type        = string
}

variable "public_2_proof_oc" {
  description = "CIDR block for public subnet 2 for Proof OC"
  type        = string
}

variable "private_1_proof_oc" {
  description = "CIDR block for private subnet 1 for Proof OC"
  type        = string
}

variable "private_2_proof_oc" {
  description = "CIDR block for private subnet 2 for Proof OC"
  type        = string
}


// Jumpbox
variable "jumpbox_ami_id_proof_oc" {
  description = "The AMI ID for the Proof OC Jumpbox"
  type        = string
}

variable "allowed_ssh_cidr_blocks_proof_oc" {
  description = "List of CIDR blocks allowed to access the Proof OC Jumpbox via SSH"
  type        = list(string)
}

variable "jumpbox_ssh_key_proof_oc" {
  description = "Name of the SSH key pair to use for the Proof OC Jumpbox"
  type        = string
}

variable "jumpbox_instance_type_proof_oc" {
  description = "EC2 instance type for the Proof OC Jumpbox"
  type        = string
}

variable "jumpbox_volume_proof_oc" {
  description = "EC2 instance volume size for the Proof OC Jumpbox"
  type        = string
}


// Web Instance
variable "web_ami_id_proof_oc" {
  description = "EC2 instance AMI for the Web Proof OC"
  type        = string
}
variable "web_ssh_key_proof_oc" {
  description = "Name of the SSH key pair to use for the Proof OC Jumpbox"
  type        = string
}

variable "web_volume_proof_oc" {
  description = "EC2 instance volume size for the Web Proof OC"
  type        = string
}

variable "web_instance_type_proof_oc" {
  description = "EC2 instance type for the Web Proof OC"
  type        = string
}


// S3
variable "images_bucket_name_proof_oc" {
  description = "Unique name for the images S3 bucket"
  type        = string
}

variable "logs_bucket_name_proof_oc" {
  description = "Unique name for the logs S3 bucket"
  type        = string
}

// Tags
variable "project_name" {
  description = "The project for resource tags"
  type        = string
  default     = "proof-oc"
}