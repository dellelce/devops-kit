
## FUNCTIONS ##

# DEVOPS must be set and be the root of our "install".

az()
{
  typeset ve="$DEVOPS/az-env"
  typeset rc=0

  [ -x "$ve/bin/az" ] &&
  {
    VIRTUAL_ENV="$ve" $ve/bin/az $*;
    rc=$?
  } ||
  {
    echo "azure cli is not installed, type \"make azure_install\" to install it."
    return 1
  }

  return $rc
}
