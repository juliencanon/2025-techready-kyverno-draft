
# Installation et utilisation du Helm chart kyverno-policies

## Installation du Helm chart kyverno-policies

Pour installer le Helm chart kyverno-policies, suivez ces étapes :

1. **Ajoutez le dépôt Helm de Kyverno** :
   ```bash
   helm repo add kyverno https://kyverno.github.io/kyverno/
   helm repo update
   ```

2. **Installez le chart kyverno-policies** :
   ```bash
   helm install kyverno-policies kyverno/kyverno-policies -n kyverno --create-namespace
   ```

3. **Pour une installation personnalisée**, créez un fichier `values.yaml` et utilisez-le :
   ```bash
   helm install kyverno-policies kyverno/kyverno-policies -n kyverno -f values.yaml
   ```

## À quoi sert kyverno-policies

Le Helm chart kyverno-policies est une collection de politiques Kyverno prédéfinies et prêtes à l'emploi qui implémentent les bonnes pratiques de sécurité et de conformité pour Kubernetes. Il offre :

1. Des politiques couvrant plusieurs catégories :
   - Sécurité des pods et des conteneurs
   - Gestion des ressources
   - Bonnes pratiques pour les déploiements
   - Conformité aux standards (PSS, NSA, MITRE, etc.)

2. Une méthode standardisée pour déployer des politiques de sécurité cohérentes à travers vos clusters

3. Des politiques testées et maintenues par la communauté Kyverno

## Comment exploiter au mieux kyverno-policies

Pour tirer le meilleur parti de kyverno-policies :

1. **Personnalisez l'activation des politiques** dans votre fichier `values.yaml` :
   ```yaml
   podSecurity:
     enabled: true
   bestPractices:
     enabled: true
   ```

2. **Ajustez le mode d'application** pour chaque groupe de politiques :
   ```yaml
   podSecurity:
     validationFailureAction: Enforce  # ou Audit
   ```

3. **Activez sélectivement les politiques individuelles** :
   ```yaml
   podSecurity:
     disallow-privileged-containers:
       enabled: true
     restrict-volume-types:
       enabled: false
   ```

4. **Surveillez les rapports de politiques** pour voir quelles ressources sont non conformes :
   ```bash
   kubectl get policyreports -A
   ```

5. **Commencez en mode Audit** avant de passer en mode Enforce pour éviter de perturber les workloads existants.

## Tips et astuces

1. **Déploiement progressif** : Commencez par déployer en mode Audit, analysez les violations, puis passez progressivement en mode Enforce.

2. **Exclusions** : Utilisez les exclusions pour les namespaces système :
   ```yaml
   global:
     excludeNamespaces:
       - kube-system
       - kube-public
   ```

3. **Intégration CI/CD** : Utilisez la CLI Kyverno pour valider les manifests avant le déploiement :
   ```bash
   kyverno apply /path/to/policies --resource deployment.yaml
   ```

4. **Surveillance** : Configurez des alertes basées sur les PolicyReports pour être notifié des violations.

5. **Mise à jour** : Mettez régulièrement à jour le chart pour bénéficier des nouvelles politiques et corrections :
   ```bash
   helm repo update
   helm upgrade kyverno-policies kyverno/kyverno-policies -n kyverno
   ```

6. **Documentation des politiques** : Générez une documentation des politiques déployées :
   ```bash
   kubectl get cpol -o yaml | kyverno document - --output markdown > policies.md
   ```

7. **Validation hors cluster** : Testez vos ressources contre les politiques avant de les déployer :
   ```bash
   kyverno apply /path/to/policies --resource /path/to/resources
   ```

Le chart kyverno-policies vous permet de mettre en place rapidement un ensemble de contrôles de sécurité éprouvés, vous évitant d'avoir à rédiger toutes les politiques de sécurité depuis zéro.

