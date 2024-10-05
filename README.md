## Welcome to my Proof of Concept AWS Terraform Solution ##

## SUMMARY:
This Terraform module is used to deploy cloud infrastructure including web servers, a VPC, an Application Load Balancer (ALB), and supporting services in AWS. The infrastructure includes:
- Auto Scaling Group (ASG) for managing web server instances
- Virtual Private Cloud (VPC) with public and private subnets
- Application Load Balancer (ALB) for traffic distribution
- Secure EC2 Jumpbox for administrative access
- S3 Buckets for static content and log storage


## DEPLOYMENT NOTES:
- The EC2 Jumpbox is configured in a public subnet for secure SSH access, and access is restricted to specific CIDR blocks. Add the needed CIDRs to the "allowed_ssh_cidr_blocks_proof_oc" variable (list form) found in the tfvar file. 
- The infrastructure requires 2 SSH key pairs to be created for accessing the jumpbox and web instances (seperate for additional security). These are configured by the variables "ssh_key_proof_oc" and "web_ssh_key_proof_oc" in the tfvars file.
- Adjust the Auto Scaling Group parameters (min, max, desired capacity) as needed for your environment.
- The project uses private subnets for web instances, which are not exposed directly to the internet.
- Ensure that the S3 buckets are set up with appropriate policies and encryption for secure storage.
- Application Load Balancer routes traffic to the web instances in private subnets to ensure high availability.


## HOW TO DEPLOY:
Enter the below commands in the "proof-oc" directory to plan/deploy the solution. Update the tfvars file name as needed:

$ terraform init

$ terraform plan -var-file=proof.tfvars

$ terraform apply -var-file=proof.tfvars

$ terraform destroy -var-file=proof.tfvars