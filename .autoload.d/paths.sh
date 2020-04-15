#/bin/bash
#
# File:         paths.sh
# Created:      080220
# Description:  setup paths
#

### FUNCTIONS ###

loadvenv()
{
 typeset venv="$1"

 [ ! -z "$VIRTUALENV" -a "$VIRTUALENV" == "$venv" ] && return 0 # already activated
 [ ! -z "$VIRTUALENV" ] && { deactivate; } # deactivate before so we have a better "environment"

 [ -f "$venv/bin/activate" ] && . $venv/bin/activate
 return $?
}

### ENV ###

 [ -z "$PYTHONPATH" -a -d "$DEVOPS/py" ] &&
 {
   export PYTHONPATH="$DEVOPS/py"
 }

 loadvenv "$DEVOPS/devops-env"

 [ -d "$DEVOPS/sh" -a $(echo "$PATH" | grep -c "$DEVOPS/sh") -eq 0 ] &&
 {
   export PATH="$DEVOPS/sh:$PATH"
 }

 [ -d "$DEVOPS/bin" -a $(echo "$PATH" | grep -c "$DEVOPS/bin") -eq 0 ] &&
 {
   export PATH="$DEVOPS/bin:$PATH"
 }

### EOF ###
