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

p 'Setup Kyverno'

p 'docker run -d -p 5000:5000 --restart=always --name registry registry:2'

pe 'colima start'
pe 'minikube start --nodes 2 -p enterprise'
pe 'kubectl get nodes'

pe 'helm repo add kyverno https://kyverno.github.io/kyverno/'
pe 'helm repo update'
pe 'helm install kyverno kyverno/kyverno -n kyverno --create-namespace'

pe 'kubectl get namespaces'

pe ''
pei 'exit'

