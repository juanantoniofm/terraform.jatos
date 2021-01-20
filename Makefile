

.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'


apply:  ## Apply the terraform and create all the resources (auto approve)
	@echo "Terraform apply"
	cd terraform; terraform fmt; terraform apply -auto-approve

install:  ## Prepare your machine to run the code 
	@echo "Installing terraform with tfenv"
	tfenv install
	mkdir -p .secrets/
	cd terraform; terraform init

destroy:  ## Destroy the resources
	@echo "Destroying"
	cd terraform; terraform destroy -auto-approve

taint: ## Taint the instance to ensure it gets recreated
	cd terraform; terraform taint digitalocean_droplet.web

refresh: taint apply ## Recreate the droplet (only) - Use `make destroy apply` re-create everything

plan:  
	cd terraform; terraform fmt; terraform plan

ssh:  ## Login to the machine using root
	cd terraform; ssh -F ssh_config.tmp jatos-web


