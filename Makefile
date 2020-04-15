# Devops Kit "Core" Makefile

ROOT=$(PWD)

# default target: Make sure no specific target is called by mistake
.PHONY: help
help:
	@for mk in mk/*.mk; do awk -f mk/help.awk $$mk; done

# all "real targets"
include mk/*.mk
