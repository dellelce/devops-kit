#
# This script expects the following variables:
#      ROOT     
KUBEHOME := $(ROOT)/kube
KUBESTABLE := "https://storage.googleapis.com/kubernetes-release/release/stable.txt"

KUBEVERS = $$(wget -O - -q $(KUBESTABLE) | sed -e 's/v//g')
KUBEURL = https://storage.googleapis.com/kubernetes-release/release/v$(KUBEVERS)/bin/linux/amd64/kubectl

# "shortcut" to next target
kubectlbin: $(ROOT)/bin/kubectl

# download and "install" kube
$(ROOT)/bin/kubectl:
	@wget -q -O bin/kubectl $(KUBEURL) && chmod +x bin/kubectl

# test target: get current version of kube
kubevers:
	@echo $(KUBEVERS)

