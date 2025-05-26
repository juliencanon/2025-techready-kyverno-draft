
<!-- .slide: data-background="./assets/techready/bkgnd.png"-->
# Exemples concrets de policies Kyverno de type mutation
![h-700](./assets/techready/Tests-Validation.png)

##==##
<!-- .slide: data-background="./assets/techready/bkgnd.png"-->
## 1. Ajout automatique de labels aux namespaces

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: add-labels-namespace
spec:
  rules:
  - name: add-labels
    match:
      resources:
        kinds:
        - Namespace
    mutate:
      patchStrategicMerge:
        metadata:
          labels:
            +(environment): "{{request.object.metadata.name}}"
            +(managed-by): "kyverno"
```
Ce policy ajoute automatiquement des labels aux nouveaux namespaces.

##==##
<!-- .slide: class="transition-bg-sfeir-2" -->
## 2. Configuration des limites de ressources par défaut

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: add-default-resources
spec:
  rules:
  - name: add-default-resources
    match:
      resources:
        kinds:
        - Pod
    exclude:
      resources:
        namespaces:
        - kube-system
    mutate:
      patchStrategicMerge:
        spec:
          containers:
            - (name): "*"
              resources:
                limits:
                  +(memory): "512Mi"
                  +(cpu): "500m"
                requests:
                  +(memory): "128Mi"
                  +(cpu): "100m"
```
Cette policy ajoute automatiquement des limites de ressources aux conteneurs qui n'en ont pas.

##==##
<!-- .slide: class="transition-bg-sfeir-2" -->
## 3. Injection de sidecar pour le monitoring

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: add-prometheus-exporter
spec:
  rules:
  - name: add-prometheus-exporter
    match:
      resources:
        kinds:
        - Deployment
    mutate:
      patchStrategicMerge:
        spec:
          template:
            spec:
              containers:
              - name: prometheus-exporter
                image: prom/node-exporter:latest
                ports:
                - containerPort: 9100
                securityContext:
                  privileged: true
                volumeMounts:
                - name: proc
                  mountPath: /host/proc
                  readOnly: true
              volumes:
              - name: proc
                hostPath:
                  path: /proc
```
Cette policy injecte automatiquement un conteneur sidecar pour l'exportation de métriques Prometheus.

##==##
<!-- .slide: class="transition-bg-sfeir-2" -->
## 4. Configuration automatique des probes de liveness et readiness

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: add-health-probes
spec:
  rules:
  - name: add-health-probes
    match:
      resources:
        kinds:
        - Deployment
    mutate:
      patchStrategicMerge:
        spec:
          template:
            spec:
              containers:
              - (name): "*"
                livenessProbe:
                  +(httpGet):
                    path: /health
                    port: 8080
                  +(initialDelaySeconds): 30
                  +(periodSeconds): 10
                readinessProbe:
                  +(httpGet):
                    path: /ready
                    port: 8080
                  +(initialDelaySeconds): 5
                  +(periodSeconds): 5
```
Cette policy ajoute automatiquement des probes de liveness et readiness aux conteneurs.

##==##
<!-- .slide: class="transition-bg-sfeir-2" -->
## 5. Injection d'un ConfigMap comme variable d'environnement

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: inject-app-config
spec:
  rules:
  - name: inject-app-config
    match:
      resources:
        kinds:
        - Deployment
        selector:
          matchLabels:
            app: myapp
    mutate:
      patchStrategicMerge:
        spec:
          template:
            spec:
              containers:
              - (name): "*"
                env:
                - name: APP_CONFIG
                  valueFrom:
                    configMapKeyRef:
                      name: app-config
                      key: config.json
```
Cette policy injecte une référence à un ConfigMap comme variable d'environnement dans les déploiements avec le label spécifique.

##==##
<!-- .slide: class="transition-bg-sfeir-2" -->
Ces exemples sont utilisés dans des environnements de production pour automatiser la configuration et assurer la cohérence des ressources Kubernetes.

