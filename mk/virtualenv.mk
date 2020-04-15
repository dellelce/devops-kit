# Python virtualenv setup

VENV := $(ROOT)/devops-env

# targets to have the virtualenv configured
$(VENV)/bin/activate:
	@python3 -m venv $(VENV) && . $(VENV)/bin/activate && pip install -U pip setuptools

.PHONY: venv
venv: $(VENV)/bin/activate

venv_test: venv
	@. $(VENV)/bin/activate && python -V && pip list

venv_install: venv
	@. $(VENV)/bin/activate && pip install -U pip setuptools  -r $(ROOT)/requirements.txt

venv_uninstall:
	@rm -rf $(VENV) && git checkout $(VENV)

