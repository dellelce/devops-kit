# Python virtualenv setup

AZVENV := $(ROOT)/az-env
AZCLIURL := "https://docs.microsoft.com/en-gb/cli/azure/install-azure-cli-linux?view=azure-cli-latest"

# targets to have the virtualenv configured
$(AZVENV)/bin/activate:
	@python3 -m venv $(AZVENV) && . $(AZVENV)/bin/activate && pip install -U pip setuptools


# $HELP$
# azure_install              Install Azure (sdk, cli)
# azure_test                 Test Azure Install (python version and list of python package)
# azure_uninstall            Uninstall Azure sdk & cli.

.PHONY: azenv
azure: $(AZVENV)/bin/activate

azure_test: azure
	@. $(AZVENV)/bin/activate && python -V && pip list

azure_install: azure
	@. $(AZVENV)/bin/activate && pip install -U pip setuptools  -r $(ROOT)/requirements-azure.txt

azure_uninstall:
	@rm -rf $(AZVENV) && git checkout $(AZVENV)
