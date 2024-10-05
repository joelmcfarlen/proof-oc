// Region
region  = ""


// VPC
vpc_cidr              = ""
public_1_proof_oc     = ""
public_2_proof_oc     = ""
private_1_proof_oc    = ""
private_2_proof_oc    = ""


// Jumpbox
jumpbox_ami_id_proof_oc            = ""  // Red Hat Enterprise Linux 9 AMI used for testing
jumpbox_instance_type_proof_oc     = ""
allowed_ssh_cidr_blocks_proof_oc   = ["",""]  // Add DEV CIDRs here in list form for Proof OC Solution access
jumpbox_ssh_key_proof_oc           = ""  // Manually create in needed region
jumpbox_volume_proof_oc            = "20"


// Web
web_volume_proof_oc          = "20"
web_instance_type_proof_oc   = "t2.micro"
web_ami_id_proof_oc          = "" // Red Hat Enterprise Linux 9 AMI used for testing
web_ssh_key_proof_oc         = ""  // Manually create in needed region


// S3
images_bucket_name_proof_oc  = "images-proof-oc-99"
logs_bucket_name_proof_oc    = "logs-proof-oc-99"


// Tags
project_name  = "proof-oc"

