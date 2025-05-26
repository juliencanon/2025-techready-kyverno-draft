➜ poc-demo-magic Setup Kyverno
➜ poc-demo-magic colima start
INFO[0001] starting colima
INFO[0001] runtime: docker
INFO[0004] starting ...                                  context=vm
INFO[0071] provisioning ...                              context=docker
INFO[0083] starting ...                                  context=docker
INFO[0085] done
➜ poc-demo-magic minikube start --nodes 2 -p enterprise
😄  [enterprise] minikube v1.35.0 on Darwin 15.4.1 (arm64)
✨  Automatically selected the docker driver. Other choices: qemu2, ssh
📌  Using Docker Desktop driver with root privileges
👍  Starting "enterprise" primary control-plane node in "enterprise" cluster
🚜  Pulling base image v0.0.46 ...
🔥  Creating docker container (CPUs=2, Memory=2200MB) ...
🐳  Preparing Kubernetes v1.32.0 on Docker 27.4.1 ...
    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...
    ▪ Configuring RBAC rules ...
🔗  Configuring CNI (Container Networking Interface) ...
🔎  Verifying Kubernetes components...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🌟  Enabled addons: default-storageclass, storage-provisioner

👍  Starting "enterprise-m02" worker node in "enterprise" cluster
🚜  Pulling base image v0.0.46 ...
🔥  Creating docker container (CPUs=2, Memory=2200MB) ...
🌐  Found network options:
    ▪ NO_PROXY=192.168.49.2
🐳  Preparing Kubernetes v1.32.0 on Docker 27.4.1 ...
    ▪ env NO_PROXY=192.168.49.2
🔎  Verifying Kubernetes components...
🏄  Done! kubectl is now configured to use "enterprise" cluster and "default" namespace by default 
➜ poc-demo-magic kubectl get nodes
NAME             STATUS   ROLES           AGE   VERSION
enterprise       Ready    control-plane   30s   v1.32.0
enterprise-m02   Ready    <none>          13s   v1.32.0
➜ poc-demo-magic helm repo add kyverno https://kyverno.github.io/kyverno/
"kyverno" already exists with the same configuration, skipping
➜ poc-demo-magic helm repo update
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "kyverno" chart repository
...Successfully got an update from the "rancher-stable" chart repository
...Successfully got an update from the "argo" chart repository
Update Complete. ⎈Happy Helming!⎈
➜ poc-demo-magic helm install kyverno kyverno/kyverno -n kyverno --create-namespace
NAME: kyverno
LAST DEPLOYED: Thu May  8 04:33:54 2025
NAMESPACE: kyverno
STATUS: deployed
REVISION: 1
NOTES:
Chart version: 3.4.1
Kyverno version: v1.14.1

Thank you for installing kyverno! Your release is named kyverno.

The following components have been installed in your cluster:
- CRDs
- Admission controller
- Reports controller
- Cleanup controller
- Background controller


⚠️  WARNING: Setting the admission controller replica count below 2 means Kyverno is not running in high availability mode.


⚠️  WARNING: PolicyExceptions are disabled by default. To enable them, set '--enablePolicyException' to true.

💡 Note: There is a trade-off when deciding which approach to take regarding Namespace exclusions. Please see the documentation at https://kyverno.io/docs/installation/#security-vs-operability to understand the risks.

