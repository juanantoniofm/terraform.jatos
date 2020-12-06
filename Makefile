

.PHONY: help
help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'


apply:
	@echo "Terraform apply"

install:  ## Prepare your machine to run the code 
	@echo "Installing terraform with tfenv"
	tfenv install
	mkdir -p .secrets/
