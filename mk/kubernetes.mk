#
# This script expects the following variables:
#      ROOT

KUBEHOME := $(ROOT)/kube
KUBESTABLE := "https://storage.googleapis.com/kubernetes-release/release/stable.txt"

KUBEVERS = $$(wget -O - -q $(KUBESTABLE) | sed -e 's/v//g')

# $HELP$
# kubevers                   Print current version of kubectl from official website

# test target: get current version of kube
kubevers:
	@echo "kubernetes " $(KUBEVERS)
