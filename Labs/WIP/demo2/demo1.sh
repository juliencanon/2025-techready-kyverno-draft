#!/bin/bash

. demo-magic.sh

# hide the evidence
clear

TYPE_SPEED=20
# see http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/bash-prompt-escape-sequences.html for escape sequences
DEMO_PROMPT="${GREEN}➜ ${CYAN}\W ${COLOR_RESET}"

p 'Démo policy forbid tag latest'

pe kubectl get nodes
pe kubectl get namespace
pe cat appli-ns.yaml
pe kubectl create -f appli-ns.yaml
pe kubectl get namespace
pe cat appli-pod.yaml
pe kubectl create -f appli-pod.yaml
kubectl get pods -n appli
kubectl delete -f appli-pod.yaml
kubectl create -f kyv-pol-disable-latest.yaml
kubectl create -f appli-pod.yaml
kubectl get pods -n appli
kubectl delete -f appli-pod.yaml
kubectl get pods -n appli
kubectl create -f appli-pod.yaml
kubectl get pods -n appli
kubectl get pods -n kyverno



pe 'helm repo add kyverno https://kyverno.github.io/kyverno/'
pe 'helm repo update'
pe 'helm install kyverno kyverno/kyverno -n kyverno --create-namespace'

pe 'kubectl get namespaces'

pe ''
pei 'exit'

