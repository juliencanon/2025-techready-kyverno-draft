helm repo add policy-reporter https://kyverno.github.io/policy-reporter
helm repo update
helm upgrade --install policy-reporter policy-reporter/policy-reporter --create-namespace -n policy-reporter --set ui.enabled=true
kubectl port-forward service/policy-reporter-ui 8081:8080 -n policy-reporter

