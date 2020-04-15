# Ansible setup - requires virtualenv.mk

# $HELP$
# ansible_install            Install Ansible in virtualenv with pip

$(VENV)/bin/ansible:
	@. $(VENV)/bin/activate && pip install -r $(ROOT)/requirements-ansible.txt

.PHONY: ansible_install
ansible_install: venv $(VENV)/bin/ansible
