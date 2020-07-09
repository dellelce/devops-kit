#
# This script expects the following variables:
#      ROOT     
TERRAHOME := $(ROOT)/terraform
TERRADOWNLOAD := "https://www.terraform.io/downloads.html"
SSHOPTS := -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null

TERRAVERS = $$(wget -O - -q $(TERRADOWNLOAD) | awk -f $(ROOT)/mk/terraform.awk  )
LTERRAVERS = $$($(ROOT)/bin/terraform version | awk 'FNR == 1 { sub(/^v/, "", $$2); print $$2 } ' )
TERRAURL = https://releases.hashicorp.com/terraform/$(TERRAVERS)/terraform_$(TERRAVERS)_linux_amd64.zip

# $HELP$
# terrabin                   Download and install latest version of terraform available in bin directory
# terravers                  Find latest version of terraform available online
# localtvers                 Print local version of terraform
# terraup                    Update terraform to latest version available online

# "shortcut" to next target
terrabin: $(ROOT)/bin/terraform

# download and "install" terraform
$(ROOT)/bin/terraform:
	@wget -q -O bin/terraform.zip $(TERRAURL) && cd bin && unzip -q terraform.zip && chmod +x terraform && rm -f terraform.zip

# test target: get current version of terraform from website
terravers:
	@echo "terraform  " $(TERRAVERS)

localtvers:
	@echo $(LTERRAVERS)

terraupclean:
	@[ $(LTERRAVERS) != $(TERRAVERS) ] && rm $(ROOT)/bin/terraform

# update terraform:
#   - delete local binary if local version is different from available online
#   - download new terraform if previous step executed
terraup: terraupclean terrabin

ALLVERS += terravers

init: terrabin
	@cd $(TERRAHOME) && $(TERRAFORM) init

plan: terrabin
	@cd $(TERRAHOME) && $(TERRAFORM) plan

apply_force: terrabin
	@cd $(TERRAHOME) && $(TERRAFORM) apply -auto-approve -input=false

destroy: terrabin
	@cd $(TERRAHOME) && $(TERRAFORM) destroy

output: terrabin
	@cd $(TERRAHOME) && $(TERRAFORM) output

show: terrabin
	@cd $(TERRAHOME) && $(TERRAFORM) show

console: terrabin
	@cd terraform && $(TERRAFORM) console

ssh: terrabin
	@ssh -i terraform/ec2.key $(SSHOPTS) $(SYSUSER)@$(ip)
