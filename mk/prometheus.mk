#
# This script expects the following variables:
#      ROOT     
PROMETHEUSHOME := $(ROOT)/prometheus
PROMETHEUSTMP := $(ROOT)/tmp/prometheus-$(RANDOM)
PROMETHEUSDOWNLOAD := "https://prometheus.io/download/"

# We only support linux at the moment
PLATFORM := linux-amd64

PROMVERS = $$(wget -O - -q $(PROMETHEUSDOWNLOAD) | awk -f $(ROOT)/mk/prometheus.awk  )
PROMETHEUSURL =  "https://github.com/prometheus/prometheus/releases/download/${PROMVERS}/prometheus-${PROMVERS}.${PLATFORM}.tar.gz"

# $HELP$
# prometheusbin              Download and Install current version of prometheus available in bin directory
# prometheusvers             Print current version of prometheus from official website

.PHONY: prometheusbin
prometheusbin: $(ROOT)/bin/prometheus

# download and "install" prometheus
$(ROOT)/bin/prometheus:
	@mkdir $(PROMETHEUSTMP) && wget -q -O $(PROMETHEUSTMP)/prometheus.tar.gz $(PROMETHEUSURL) && tar xzf $(PROMETHEUSTMP)/prometheus.tar.gz -C $(PROMETHEUSTMP) && mv $(PROMETHEUSTMP)/$(PLATFORM)/prometheus $(ROOT)/bin/ &&  rm -rf $(PROMETHEUSTMP) 

# get current version of prometheus
.PHONY: prometheusvers
prometheusvers:
	@echo $(PROMETHEUSVERS)
