# Devops Kit "Core" Makefile

# $HELP$
# allvers                    Print version of all modules that can be installed

AWK  := $$( type gawk >/dev/null 2>&1 && echo "gawk" || echo "awk")
ROOT  = $(PWD)

# default target: Make sure no specific target is called by mistake
.PHONY: help
help:
	@for mk in mk/*.mk Makefile; do awk -f mk/help.awk $$mk; done

# all "real targets"
include mk/*.mk

allvers: $(ALLVERS)
