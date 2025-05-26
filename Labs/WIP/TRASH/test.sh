#!/bin/bash

########################
# include the magic
########################
. demo-magic.sh

# hide the evidence
clear

TYPE_SPEED=20
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"

pe 'kubectl get nodes'
pe 'kubectl get ns'

pe 'kubectl get pods -n kube-system'
pe ''
