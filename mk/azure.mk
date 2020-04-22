# Python virtualenv setup

AZVENV := $(ROOT)/az-env
AZCLIURL := "https://docs.microsoft.com/en-gb/cli/azure/install-azure-cli-linux?view=azure-cli-latest"

# targets to have the virtualenv configured
$(AZVENV)/bin/activate:
	@python3 -m venv $(AZVENV) && . $(AZVENV)/bin/activate && pip install -U pip setuptools

.PHONY: azenv
azenv: $(AZVENV)/bin/activate

azenv_test: azenv
	@. $(AZVENV)/bin/activate && python -V && pip list

azenv_install: azenv
	@. $(AZVENV)/bin/activate && pip install -U pip setuptools  -r $(ROOT)/requirements-azure.txt

azure_install: azenv_install

azenv_uninstall:
	@rm -rf $(AZVENV) && git checkout $(AZVENV)

