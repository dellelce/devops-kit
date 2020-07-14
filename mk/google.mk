# Python virtualenv setup

GCVENV   := $(ROOT)/gcp-env
GSDKURL  := https://cloud.google.com/sdk/docs/quickstart-linux
GSDKVERS  = $$(wget -q -O - $(GSDKURL) | awk -f mk/gcloudsdk.awk)
GSDKDL   := https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-$(GSDKVERS)-linux-x86_64.tar.gz

# targets to have the virtualenv configured
$(GCVENV)/bin/activate:
	@python3 -m venv $(GCVENV) && . $(GCVENV)/bin/activate && pip install -U pip setuptools


# $HELP$
# gcp_install                Install Google Cloud (sdk, cli)
# gcp_test                   Test Google Cloud Install (python version and list of python package)
# gcp_uninstall              Uninstall Google Cloud sdk & cli.

.PHONY: gcpenv
gcp: $(GCVENV)/bin/activate


gcp_test: gcp
	@. $(GCVENV)/bin/activate && python -V && pip list

gcp_install: gcp
	@. $(GCVENV)/bin/activate && pip install -U pip setuptools  -r $(ROOT)/requirements-gcp.txt

gcp_uninstall:
	@rm -rf $(GCVENV) && git checkout $(GCVENV)

gsdkdl:
	@mkdir -p tmp/gcloud && wget -q -O tmp/gcloud/gloudsdk.tar.gz $(GSDKDL)

gsdkvers:
	@echo $(GSDKVERS)
