#
# This script expects the following variables:
#      ROOT     
CONSULHOME := $(ROOT)/consul
CONSULDOWNLOAD := "https://www.consul.io/downloads.html"

CONSULVERS = $$(wget -O - -q $(CONSULDOWNLOAD) | awk -f $(ROOT)/mk/consul.awk  )
CONSULURL = https://releases.hashicorp.com/consul/$(CONSULVERS)/consul_$(CONSULVERS)_linux_amd64.zip

# "shortcut" to next target
consulbin: $(ROOT)/bin/consul

# download and "install" consul
$(ROOT)/bin/consul:
	@wget -q -O bin/consul.zip $(CONSULURL) && cd bin && unzip -q consul.zip && chmod +x consul && rm -f consul.zip

# test target: get current version of consul
consulvers:
	@echo $(CONSULVERS)

