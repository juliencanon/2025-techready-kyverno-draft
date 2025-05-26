#!/bin/bash

. demo-magic.sh
clear

TYPE_SPEED=30
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"


pe 'cat mut-ns-policy.yaml'
pe 'kubectl create -f mut-ns-policy.yaml'

pe 'cat mut-deploy-inject-policy.yaml'
pe 'kubectl create -f mut-deploy-inject-policy.yaml'

pe 'cat mut-pod-policy.yaml'
pe 'kubectl create -f mut-pod-policy.yaml'

pe 'kubectl get clusterpolicy'

pe 'cat mut-demo-ns.yaml'
pe 'kubectl create -f mut-demo-ns.yaml'
pe 'kubectl get namespace'
pe 'kubectl get namespace mut-demo -o yaml'

pe 'cat nginx-deployment-version.yaml'
pe 'kubectl create -f nginx-deployment-version.yaml'
pe 'kubectl get deploy -n mut-demo'
pe 'kubectl get deploy -n mut-demo -o yaml'
pe 'kubectl get pods -n mut-demo'
pe 'kubectl get pods -n mut-demo -o name | head -1 | xargs kubectl -o yaml -n mut-demo get'

pei 'exit'

