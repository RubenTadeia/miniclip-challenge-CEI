# miniclip-challenge-CEI

## For this challenge the following version of terraform was used

	Terraform v1.2.3
	on windows_amd64
	provider registry.terraform.io/hashicorp/aws v4.21.0
	
## Commands for terraform	
	
	cd terraform/main
	terraform init
	terraform plan -var-file=./../envvars/development.tfvar
	terraform apply -var-file=./../envvars/development.tfvar
	terraform destroy -var-file=./../envvars/development.tfvar
	
## Environment Variable Files
	
	In the envvars folder we have two files used in this challenge:
	- development.tfvar
	- staging.tfvars