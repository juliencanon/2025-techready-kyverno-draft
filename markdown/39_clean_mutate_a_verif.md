
# Exemples concrets de policies Kyverno de type clean

Voici des exemples réels de policies Kyverno de type "clean" utilisées dans des environnements Kubernetes :

## 1. Nettoyage des labels obsolètes

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: clean-deprecated-labels
spec:
  rules:
  - name: remove-deprecated-labels
    match:
      resources:
        kinds:
        - Pod
        - Deployment
        - StatefulSet
    mutate:
      patchStrategicMerge:
        metadata:
          labels:
            -(beta.kubernetes.io/arch): null
            -(beta.kubernetes.io/os): null
```
Cette policy supprime les labels Kubernetes obsolètes qui ont été remplacés par de nouvelles versions.

## 2. Nettoyage des annotations de déploiement

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: clean-deployment-annotations
spec:
  rules:
  - name: remove-deployment-timestamps
    match:
      resources:
        kinds:
        - Deployment
    mutate:
      patchStrategicMerge:
        metadata:
          annotations:
            -(deployment.kubernetes.io/revision): null
            -(kubernetes.io/change-cause): null
```
Cette policy supprime les annotations liées aux révisions de déploiement qui peuvent s'accumuler au fil du temps.

## 3. Nettoyage des sélecteurs non utilisés

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: clean-unused-selectors
spec:
  rules:
  - name: remove-unused-pod-selector
    match:
      resources:
        kinds:
        - Service
    mutate:
      patchStrategicMerge:
        spec:
          -(selector):
            {{- if hasKey .request.object.spec "selector" }}
            {{- if hasKey .request.object.spec "clusterIP" }}
            {{- if eq .request.object.spec.clusterIP "None" }}
            {{- if hasKey .request.object.spec "selector" }}
            null
            {{- end }}
            {{- end }}
            {{- end }}
            {{- end }}
```
Cette policy supprime les sélecteurs inutiles des services headless qui n'en ont pas besoin.

## 4. Nettoyage des variables d'environnement sensibles

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: clean-sensitive-env-vars
spec:
  rules:
  - name: remove-debug-env-vars
    match:
      resources:
        kinds:
        - Pod
        - Deployment
        - StatefulSet
    mutate:
      patchStrategicMerge:
        spec:
          template:
            spec:
              containers:
              - (name): "*"
                env:
                - (name): DEBUG
                  -(value): null
                - (name): VERBOSE
                  -(value): null
                - (name): DEVELOPMENT_MODE
                  -(value): null
```
Cette policy supprime les variables d'environnement liées au débogage qui ne devraient pas être présentes en production.

## 5. Nettoyage des limites de ressources excessives

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: clean-excessive-resources
spec:
  rules:
  - name: normalize-resource-limits
    match:
      resources:
        kinds:
        - Deployment
        - StatefulSet
    mutate:
      patchStrategicMerge:
        spec:
          template:
            spec:
              containers:
              - (name): "*"
                resources:
                  limits:
                    memory: "{{ div (mul (getMatch .element.resources.limits.memory `^([0-9]+)Gi$` 1) 1024) 1 }}Mi"
                    {{- if gt (getMatch .element.resources.limits.memory `^([0-9]+)Gi$` 1) 8 }}
                    memory: "8Gi"
                    {{- end }}
```
Cette policy normalise les limites de ressources excessives, par exemple en limitant la mémoire à 8Gi maximum.

## 6. Nettoyage des champs de sécurité inutiles

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: clean-security-fields
spec:
  rules:
  - name: remove-unnecessary-security-contexts
    match:
      resources:
        kinds:
        - Pod
    mutate:
      patchStrategicMerge:
        spec:
          containers:
          - (name): "*"
            securityContext:
              -(privileged): null
              {{- if hasKey .element.securityContext "privileged" }}
              {{- if eq .element.securityContext.privileged false }}
              {{- end }}
              {{- end }}
```
Cette policy supprime les champs de sécurité redondants, comme `privileged: false` qui est la valeur par défaut.

## 7. Nettoyage des configurations de sonde redondantes

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: clean-redundant-probes
spec:
  rules:
  - name: normalize-probes
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
                {{- if hasKey .element "livenessProbe" }}
                {{- if hasKey .element "readinessProbe" }}
                {{- if eq .element.livenessProbe.httpGet.path .element.readinessProbe.httpGet.path }}
                {{- if eq .element.livenessProbe.httpGet.port .element.readinessProbe.httpGet.port }}
                readinessProbe:
                  -(httpGet): null
                  httpGet:
                    path: "{{ .element.livenessProbe.httpGet.path }}"
                    port: {{ .element.livenessProbe.httpGet.port }}
                {{- end }}
                {{- end }}
                {{- end }}
                {{- end }}
```
Cette policy normalise les configurations de sondes redondantes en réutilisant les mêmes paramètres.

Ces exemples sont utilisés dans des environnements de production pour maintenir la propreté et la cohérence des configurations Kubernetes, réduire l'encombrement et améliorer la sécurité en supprimant les informations sensibles ou obsolètes.

