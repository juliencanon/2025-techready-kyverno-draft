
# Exemple de policy Kyverno de type generate pour créer un PodDisruptionBudget

Voici un exemple concret de policy Kyverno qui génère automatiquement un PodDisruptionBudget (PDB) à chaque fois qu'un Deployment est créé :

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: generate-pdb-for-deployment
spec:
  rules:
  - name: create-pdb-for-deployment
    match:
      resources:
        kinds:
        - Deployment
    generate:
      kind: PodDisruptionBudget
      apiVersion: policy/v1
      name: "{{request.object.metadata.name}}-pdb"
      namespace: "{{request.object.metadata.namespace}}"
      synchronize: true
      data:
        spec:
          minAvailable: 1
          selector:
            matchLabels:
              app: "{{request.object.metadata.labels.app}}"
```

Cette policy :
- S'applique à chaque création de Deployment
- Génère un PodDisruptionBudget avec le même nom que le Deployment suivi de "-pdb"
- Place le PDB dans le même namespace que le Deployment
- Configure le PDB pour maintenir au moins 1 pod disponible pendant les perturbations
- Utilise le label "app" du Deployment pour le sélecteur du PDB
- Utilise l'option `synchronize: true` pour que le PDB soit mis à jour si le Deployment change

Cette policy est particulièrement utile pour garantir la haute disponibilité des applications en empêchant l'éviction simultanée de tous les pods d'un Deployment lors des opérations de maintenance du cluster.

