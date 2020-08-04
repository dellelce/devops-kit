#
# This script expects the following variables:
#      ROOT

KUBEHOME := $(ROOT)/kube
KUBESTABLE := "https://storage.googleapis.com/kubernetes-release/release/stable.txt"
KUBEVERS = $$(wget -O - -q $(KUBESTABLE) | sed -e 's/v//g')

#etcd
ETCDDOWNLOAD := "https://github.com/etcd-io/etcd/releases"
ETCDVERS = $$(wget -O - -q $(ETCDDOWNLOAD) | awk -vext=tar.gz -f $(ROOT)/mk/github.awk )

#coredns
COREDNSDOWNLOAD := "https://github.com/coredns/coredns/releases"
COREDNSVERS = $$(wget -O - -q $(COREDNSDOWNLOAD) | awk -vext=tar.gz -f $(ROOT)/mk/github.awk )

# $HELP$
# kubevers                   Print current version of kubectl from official website

# test target: get current version of kube
kubevers:
	@echo "kubernetes " $(KUBEVERS)

# etcd targets
etcdvers:
	@echo "etcd       " $(ETCDVERS)

# coredns targets
corednsvers:
	@echo "coredns    " $(COREDNSVERS)
