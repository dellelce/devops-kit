#
# This script expects the following variables:
#      ROOT     
PACKERHOME := $(ROOT)/packer
PACKERDOWNLOAD := "https://www.packer.io/downloads"

# TODO: Review use of --no-check-certificate (not secure)
PACKERVERS = $$(wget -O - --no-check-certificate -q $(PACKERDOWNLOAD) | $(AWK) -f $(ROOT)/mk/packer.awk  )
LPACKERVERS = $$($(ROOT)/bin/packer version | $(AWK) 'FNR == 1 { sub(/^v/, "", $$2); print $$2 } ' )
PACKERURL = https://releases.hashicorp.com/packer/$(PACKERVERS)/packer_$(PACKERVERS)_linux_amd64.zip

# $HELP$
# packerbin                   Download and install latest version of packer available in bin directory
# packervers                  Find latest version of packer available online
# localpvers                  Print local version of packer
# packerup                    Update packer to latest version available online

# "shortcut" to next target
packerbin: $(ROOT)/bin/packer

# download and "install" packer
$(ROOT)/bin/packer:
	@wget -q -O bin/packer.zip $(PACKERURL) && cd bin && unzip -q packer.zip && chmod +x packer && rm -f packer.zip

# test target: get current version of packer from website
packervers:
	@echo "packer  " $(PACKERVERS)

localpvers:
	@echo $(LPACKERVERS)

packerupclean:
	@[ $(LPACKERVERS) != $(PACKERVERS) ] && rm $(ROOT)/bin/packer

packerurl:
	@echo $(PACKERURL)

# update packer:
#   - delete local binary if local version is different from available online
#   - download new packer if previous step executed
packerup: packerupclean packerbin

ALLVERS += packervers
