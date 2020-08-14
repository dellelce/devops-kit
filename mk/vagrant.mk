#
# This script expects the following variables:
#      ROOT     
VAGRANTHOME := $(ROOT)/vagrant
VAGRANTDOWNLOAD := "https://www.vagrantup.com/downloads.html"

VAGRANTVERS = $$(wget -O - -q $(VAGRANTDOWNLOAD) | $(AWK) -f $(ROOT)/mk/vagrant.awk  )
VAGRANTURL = https://releases.hashicorp.com/vagrant/$(VAGRANTVERS)/vagrant_$(VAGRANTVERS)_linux_amd64.zip

# $HELP$
# vagrantbin                 Download and install vagrant in local bin directory
# vagrantvers                Print current version from of vagrant from official website

# "shortcut" to next target
vagrantbin: $(ROOT)/bin/vagrant

# download and "install" vagrant
$(ROOT)/bin/vagrant:
	@wget -q -O bin/vagrant.zip $(VAGRANTURL) && cd bin && unzip -q vagrant.zip && chmod +x vagrant && rm -f vagrant.zip

# test target: get current version of vagrant
vagrantvers:
	@echo "vagrant    " $(VAGRANTVERS)

ALLVERS += vagrantvers
