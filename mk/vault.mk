#
# This script expects the following variables:
#      ROOT
VAULTHOME := $(ROOT)/vault
VAULTDOWNLOAD := "https://developer.hashicorp.com/vault/downloads"

PLATFORM := $$( ./mk/platform.sh | tr '-' '_')

VAULTVERS = $$(wget -O - -q $(VAULTDOWNLOAD) | $(AWK) -f $(ROOT)/mk/hashicorp-downloads.awk  )
VAULTURL = https://releases.hashicorp.com/vault/$(VAULTVERS)/vault_$(VAULTVERS)_$(PLATFORM).zip

# $HELP$
# vaultbin                   Download and install latest version of vault
# vaultvers                  Print version of latest vault available

# "shortcut" to next target
vaultbin: $(ROOT)/bin/vault

# download and "install" vault
$(ROOT)/bin/vault:
	@wget -q -O bin/vault.zip $(VAULTURL) && cd bin && unzip -q vault.zip && chmod +x vault && rm -f vault.zip

# test target: get current version of vault
vaultvers:
	@echo "vault      " $(VAULTVERS)

ALLVERS += vaultvers
