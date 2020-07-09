# devopskit: All things DevOps in a single repo

This is a collections of tools & scripts that I used for my personal projects and at work.

## Installing

To use the scripts & makefiles the ```.autoload``` and ```.autoload.d``` directory must be sourced:

```bash
# Switch to install directory with files

bash$  cd /path/devops-kit

# Load ("source") files in the following order:

bash$   . .autoload
bash$ for f in .autoload.d/*.sh; do [ -f "$f" ] && . "$f"; done
```
