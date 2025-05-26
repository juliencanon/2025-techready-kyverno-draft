
<!-- .slide: class="transition-bg-sfeir-2" -->
# Historique des solutions

Notes:
Policy-as-Code 
Software Supply Chain Security

##==##
<!-- .slide: class="transition-bg-sfeir-2" -->
## Première solution : Gatekeeper basée sur OPA (Juin 2017)
![h500](./assets/kubernetes/gatekeeper.png)
Notes: 
- implémente un moteur générique pour implémenter ses policies
- se base sur le moteur d'open policy agent (OPA)
- le langage est donc le rego
- OPA Gatekeeper est un projet graduated de la CNCF
- Open Policy Agent propose au travers de Rego un outil d'écriture de policies généraliste. 
- Etant le premier outil sur le créneau, une grande communauté s'est formée et il est facile de trouver de la documentation et des exemples.
- Le rego reste cependant assez peu intuitif et accessible 


##==##
<!-- .slide: class="flex-row center" data-background="./assets/techready/bkgnd.png"-->
![h500](./assets/techready/ConstraintOPA.png)


##==##
<!-- .slide: class="transition-bg-sfeir-2" -->
## Kyverno arrive en second (Nirmata : 2019)
![h500](./assets/new/kyverno-transparent.png)
Notes: 
- Initié en Mai 2019 par la société Nirmata
- Souhaite résoudre la complexité de Gatekeeper
- La proposition est de pouvoir écrire les policies directement en yaml
- Plus facile à écrire et à relire
## Améliorations :
- Policies plus lisibles
- Collection sur étagère
## Inconvénients :
- La performance (parser du yaml est bien plus lourd qu'un moteur d'évaluation)
- Sorti des policies fournies, difficile d'en écrire de nouvelles (la syntaxe n'est pas au niveau d'un langage)
- Necessite toujours l'installation d'un produit tiers (et stratégique/critique)

##==##
<!-- .slide: class="with-code-dark max-height" data-background="./assets/techready/bkgnd.png"-->
```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: add-labels
  annotations:
    policies.kyverno.io/title: Add Labels
    policies.kyverno.io/description: Labels are used as an important source of metadata
spec:
  rules:
  - name: add-labels
    match:
      any:
      - resources:
          kinds:
          - Pod
          - Service
          - ConfigMap
          - Secret
    mutate:
      patchStrategicMerge:
        metadata:
          labels:
            foo: bar
```

##==##
<!-- .slide: class="transition-bg-sfeir-2" -->
## Kubernetes introduit les VAP et MAP

- CEL apparaît dans k8s pour les validation rules dans les CRD
- Utilisé pour créer les ValidatingAdmissionPolicy et MutatingAdmissionPolicy (Alpha en 1.26)
- Langage de validation d'expression pre-compilé (faible latence)
- Simplicité de lecture
- *Nativement intégré dans kubernetes !*
<!-- .element: class="list-fragment" -->

Notes: 
L'intégration du Common Expression Language (CEL) dans Kyverno a été une évolution progressive.

Bien que CEL ait été introduit dans Kubernetes avec ValidatingAdmissionPolicy (alpha en v1.26 en décembre 2022), Kyverno a commencé à intégrer le support de CEL dans ses politiques avant que ValidatingAdmissionPolicy ne soit GA.

Un article de blog de Nirmata (le créateur de Kyverno) intitulé "Using Kubernetes CEL in Kyverno Policies" a été publié le 9 octobre 2023, détaillant comment écrire des expressions CEL dans les politiques Kyverno pour la validation des ressources.

##==##
<!-- .slide: class="transition-bg-sfeir-2" -->
## Kyverno pivote sur le CEL ( Mai 2023 / Version 1.10 )
![h500](./assets/new/kyverno-transparent.png)

Notes: 
Cela indique que le support de CEL dans Kyverno est devenu une fonctionnalité utilisable et documentée autour de cette période, probablement avec la version Kyverno 1.10 (mai 2023) ou 1.11 (novembre 2023) qui a apporté des améliorations significatives à la validation des politiques.

## Kubernetes propose une implémentation native :
- ValidatingAdmissionPolicy et MutatingAdmissionPolicy <BR>
    https://github.com/datreeio/validating-admission-policy
<BR><BR>
- Apparaît en beta dans kubernetes 1.26 (8 Décembre 2022)
- Passe en GA dans kubernetes 1.30 (17 Avril 2024)
- Se base sur le CEL : un moteur d'évaluation d'expression simple et performant
- Le langage est indépendant, propose un playground pour le tester
- Le langage est pré-compilé, prévu pour une évaluation extrêment rapide (prévue pour les reverse-proxy à l'origine)


##==##
<!-- .slide: class="transition-bg-sfeir-2" -->
## Kyverno ne se limite pas à un Admission Controller
![h500](./assets/techready/toolbox-trans.png)

Notes: 
- Se voit comme une boîte à outil gérant tous les use-cases de la conformité
- S'installe dans le cluster, mais fournit également une version en ligne de commande (CLI)
- Kyverno 1.11 (16 Novembre 2023) implémente le langage CEL dans ses policies
- La bibliothèque de policies se ré-écrit progressivement en CEL

