#!/bin/bash

. demo-magic.sh
clear

TYPE_SPEED=30
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"


pe 'cat gen-netpol-policy.yaml'
pe 'kubectl create -f gen-netpol-policy.yaml'

pe 'cat gen-quota-policy.yaml'
pe 'kubectl create -f gen-quota-policy.yaml'

pe 'kubectl get clusterpolicy'

pe 'cat gen-demo-ns.yaml'
pe 'kubectl create -f gen-demo-ns.yaml'
pe 'kubectl get namespace'
pe 'kubectl get NetworkPolicy -n gen-demo'
pe 'kubectl get NetworkPolicy -n gen-demo -o yaml'
pe 'kubectl get quota -n gen-demo'

pei 'exit'

