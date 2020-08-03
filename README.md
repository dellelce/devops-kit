# devopskit: All things DevOps in a single repo

A collections of tools & scripts that help download and install tools commonly used/needed by DevOps Engineers like:

* Kubectl
* Vagrant
* Hashicorp Vault
* AWS client
* GCP client (in progress)
* Kubernetes (in progress)
* Ansible
* Prometheus
* Helm

## Install

To use the scripts & makefiles the ```.autoload``` and ```.autoload.d``` directory must be sourced:

```bash
# Switch to install directory with files

bash$  cd /path/devops-kit

# Load ("source") files in the following order:

bash$ . .autoload
bash$ for f in .autoload.d/*.sh; do [ -f "$f" ] && . "$f"; done
```
