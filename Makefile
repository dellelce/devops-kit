# Web Install Makefile

ROOT=$(PWD)
VENV := devops-env

# default target: help!
.PHONY: help
help:
	@cat docs/help.txt && echo

# all "real targets"
include mk/*.mk
