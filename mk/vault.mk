#
# This script expects the following variables:
#      ROOT     
VAULTHOME := $(ROOT)/vault
VAULTDOWNLOAD := "https://www.vaultproject.io/downloads/"

VAULTVERS = $$(wget -O - -q $(VAULTDOWNLOAD) | awk -f $(ROOT)/mk/vault.awk  )
VAULTURL = https://releases.hashicorp.com/vault/$(VAULTVERS)/vault_$(VAULTVERS)_linux_amd64.zip

# $HELP$
# vaultbin                   Install latest version of vault availab
# vaultvers                  Print version of latest vault available

# "shortcut" to next target
vaultbin: $(ROOT)/bin/vault

# download and "install" vault
$(ROOT)/bin/vault:
	@wget -q -O bin/vault.zip $(VAULTURL) && cd bin && unzip -q vault.zip && chmod +x vault && rm -f vault.zip

# test target: get current version of vault
vaultvers:
	@echo $(VAULTVERS)

