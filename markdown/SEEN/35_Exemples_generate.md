
##==##
<!-- .slide: data-background="./assets/techready/bkgnd.png"-->
# Exemples concrets de policies Kyverno de type generate

Voici des exemples réels de policies Kyverno de type "generate" utilisées dans des environnements Kubernetes :
Ces exemples sont utilisés dans des environnements de production pour automatiser la création de ressources associées et garantir que chaque namespace dispose des configurations de base nécessaires dès sa création.

##==##
<!-- .slide: data-background="./assets/techready/bkgnd.png"-->
## 1. Génération automatique de NetworkPolicy

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: add-networkpolicy
spec:
  rules:
  - name: default-deny-ingress
    match:
      resources:
        kinds:
        - Namespace
    exclude:
      resources:
        namespaces:
        - kube-system
        - kube-public
    generate:
      kind: NetworkPolicy
      name: default-deny-ingress
      namespace: "{{request.object.metadata.name}}"
      data:
        spec:
          podSelector: {}
          policyTypes:
          - Ingress
```
Cette policy génère automatiquement une NetworkPolicy de type "deny all ingress" pour chaque nouveau namespace créé.

##==##
<!-- .slide: data-background="./assets/techready/bkgnd.png"-->
## 2. Génération de quotas de ressources par namespace

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: add-namespace-quota
spec:
  rules:
  - name: generate-resourcequota
    match:
      resources:
        kinds:
        - Namespace
    generate:
      kind: ResourceQuota
      name: default-resourcequota
      namespace: "{{request.object.metadata.name}}"
      data:
        spec:
          hard:
            requests.cpu: "4"
            requests.memory: 8Gi
            limits.cpu: "8"
            limits.memory: 16Gi
            pods: "20"
```
Cette policy génère automatiquement un ResourceQuota avec des limites prédéfinies pour chaque nouveau namespace.

##==##
<!-- .slide: data-background="./assets/techready/bkgnd.png"-->
## 3. Génération de rôles RBAC par défaut

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: generate-owner-rolebinding
spec:
  rules:
  - name: generate-owner-role
    match:
      resources:
        kinds:
        - Namespace
    generate:
      kind: Role
      name: namespace-owner
      namespace: "{{request.object.metadata.name}}"
      data:
        rules:
        - apiGroups: ["*"]
          resources: ["*"]
          verbs: ["*"]
  - name: generate-owner-rolebinding
    match:
      resources:
        kinds:
        - Namespace
    generate:
      kind: RoleBinding
      name: namespace-owner-binding
      namespace: "{{request.object.metadata.name}}"
      data:
        roleRef:
          apiGroup: rbac.authorization.k8s.io
          kind: Role
          name: namespace-owner
        subjects:
        - kind: User
          name: "{{request.userInfo.username}}"
          apiGroup: rbac.authorization.k8s.io
```
Cette policy génère un rôle et un RoleBinding qui donnent au créateur du namespace des droits d'administration sur celui-ci.

##==##
<!-- .slide: data-background="./assets/techready/bkgnd.png"-->
## 4. Génération de ConfigMap pour la configuration d'application

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: generate-default-configs
spec:
  rules:
  - name: generate-default-app-config
    match:
      resources:
        kinds:
        - Namespace
        selector:
          matchLabels:
            environment: production
    generate:
      kind: ConfigMap
      name: app-default-config
      namespace: "{{request.object.metadata.name}}"
      data:
        data:
          app.properties: |
            log.level=INFO
            metrics.enabled=true
            tracing.enabled=true
            cache.ttl=3600
```
Cette policy génère un ConfigMap contenant des configurations par défaut pour les applications dans les namespaces de production.

##==##
<!-- .slide: data-background="./assets/techready/bkgnd.png"-->
## 5. Génération de Secret pour les certificats TLS

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: generate-self-signed-cert
spec:
  rules:
  - name: generate-self-signed-certificate
    match:
      resources:
        kinds:
        - Namespace
    generate:
      kind: Secret
      name: tls-cert
      namespace: "{{request.object.metadata.name}}"
      synchronize: true
      data:
        type: kubernetes.io/tls
        data:
          tls.crt: "{{generate_certificate(2048, '365', 'false', 'organization', 'example.com', '*.{{request.object.metadata.name}}.svc.cluster.local')}}"
```
Cette policy génère automatiquement un certificat TLS auto-signé pour chaque nouveau namespace, en utilisant les fonctions intégrées de Kyverno pour la génération de certificats.

##==##
<!-- .slide: data-background="./assets/techready/bkgnd.png"-->
## 6. Génération de ServiceAccount par défaut

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: generate-default-serviceaccount
spec:
  rules:
  - name: create-serviceaccount
    match:
      resources:
        kinds:
        - Namespace
    generate:
      kind: ServiceAccount
      name: app-serviceaccount
      namespace: "{{request.object.metadata.name}}"
      data:
        automountServiceAccountToken: false
```
Cette policy génère un ServiceAccount par défaut pour chaque nouveau namespace, avec l'option automountServiceAccountToken désactivée pour des raisons de sécurité.


