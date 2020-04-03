# Web Install Makefile

ROOT=$(PWD)
VENV := devops-env

# all "real targets" 
include mk/*.mk

# default target: help!
.PHONY: help
help:
	@cat docs/help.txt && echo
