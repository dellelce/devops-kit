#
# This script expects the following variables:
#      ROOT     
HELMHOME := $(ROOT)/helm
HELMTMP := $(ROOT)/tmp/helm-$(RANDOM)
HELMDOWNLOAD := "https://github.com/helm/helm/releases"

# We only support linux at the moment
PLATFORM := linux-amd64

HELMVERS = $$(wget -O - -q $(HELMDOWNLOAD) | awk -vext=tar.gz -f $(ROOT)/mk/github.awk  )
HELMURL =  "https://get.helm.sh/helm-v$(HELMVERS)-$(PLATFORM).tar.gz"

# $HELP$
# helmbin                    Download and Install current version of helm available in bin directory
# helmvers                   Print current version of helm from official website

.PHONY: helmbin
helmbin: $(ROOT)/bin/helm

# download and "install" helm
$(ROOT)/bin/helm:
	@mkdir $(HELMTMP) && wget -q -O $(HELMTMP)/helm.tar.gz $(HELMURL) && tar xzf $(HELMTMP)/helm.tar.gz -C $(HELMTMP) && mv $(HELMTMP)/$(PLATFORM)/helm $(ROOT)/bin/helm && rm -rf $(HELMTMP) 

# get current version of helm
.PHONY: helmvers
helmvers:
	@echo "helm       " $(HELMVERS)

ALLVERS += helmvers
