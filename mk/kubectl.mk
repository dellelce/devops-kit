#
# This script expects the following variables:
#      ROOT     

# This variables are both here and in "kubernetes.mk" to allow standalone install of "kubectl"
KUBEHOME := $(ROOT)/kube
KUBESTABLE := "https://storage.googleapis.com/kubernetes-release/release/stable.txt"

KUBEVERS = $$(wget -O - -q $(KUBESTABLE) | sed -e 's/v//g')
KUBEURL = https://storage.googleapis.com/kubernetes-release/release/v$(KUBEVERS)/bin/linux/amd64/kubectl

# $HELP$
# kubectlbin                 Download and install current version of kubectl available in bin directory

# "shortcut" to next target
kubectlbin: $(ROOT)/bin/kubectl

# download and "install" kube
$(ROOT)/bin/kubectl:
	@wget -q -O bin/kubectl $(KUBEURL) && chmod +x bin/kubectl

ALLVERS += kubevers
