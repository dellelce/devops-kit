# Ansible setup - requires virtualenv.mk

$(VENV)/bin/ansible:
	@. $(VENV)/bin/activate && pip install -r $(ROOT)/requirements-ansible.txt

.PHONY: ansible_install
ansible_install: $(VENV)/bin/ansible
