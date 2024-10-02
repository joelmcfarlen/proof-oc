// Region
region  = "us-east-1"


// VPC
vpc_cidr              = "10.1.0.0/16"
public_1_proof_oc     = "10.1.0.0/24"
public_2_proof_oc     = "10.1.1.0/24"
private_1_proof_oc    = "10.1.2.0/24"
private_2_proof_oc    = "10.1.3.0/24"
az1_proof_oc          = "us-east-1a"
az2_proof_oc          = "us-east-1a"


// Jumpbox
jumpbox_ami_id_proof_oc            = "ami-TBU"
jumpbox_instance_type_proof_oc     = "t2.micro"
allowed_ssh_cidr_blocks_proof_oc   = ["0.0.0.0/0"] // (Add DEVs IPs here for access)
ssh_key_proof_oc                   = "TBU"
jumpbox_volume_proof_oc            = "20"


// Web
web_volume_proof_oc          = "20"
web_instance_type_proof_oc   = "t2.micro"
web_ami_id_proof_oc          = "TBU"


// Tags
project_name  = "proof-oc"

