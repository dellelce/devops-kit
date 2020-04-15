# Devops Kit "Core" Makefile

ROOT=$(PWD)

# default target: Make sure no specific target is called by mistake
.PHONY: help
help:
	@cat docs/help.txt && echo

# all "real targets"
include mk/*.mk
