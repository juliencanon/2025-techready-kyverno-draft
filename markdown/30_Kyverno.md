
<!-- .slide: data-background="./assets/kubernetes/iletaitunefois.png"-->

Notes:
# Revenons à kyverno
## Le 12 Juillet 2022 le projet rejoint la CNCF avec le statut "Incubation"


##==##
<!-- .slide: class="transition-bg-sfeir-2" -->
### Installation de Kyverno
![h-500 center](./assets/techready/demo1.jpg)


##==##
<!-- .slide: data-background="./assets/techready/bkgnd.png"-->
### Ce que kyverno sait faire :
- Validation des requêtes ( sur create, update, delete, patch...)
- Mutation des requêtes (rectification du contenu, ajout, offuscation, cryptage...)
- Generation de nouvelles resources
- Verify Images Rules (contrôle de la supply chain via Notary ou Sigstore) 
- Cleanup Rules (sur expression cron, ou sur présence de label/ttl)
- PolicyExceptions (Pouvoir gérer une exception ponctuelle)
- Background Scans (vérifier les policies en continu en tâche de fond)
- Auto-Gen Rules (un coup de génie !)
- Generation des VAP et MAP (dans kubernetes)
- kyverno CLI (apply / test / generation documentation )
<!-- .element: class="list-fragment" -->

##==##
<!-- .slide: class="flex-row center" data-background="./assets/techready/bkgnd-demo-title2.png"-->
### Commençons à jouer


##==##
<!-- .slide: data-background="./assets/techready/bkgnd.png"-->
### Méthodologie :
- Commencer tranquillement
- Une première policy en Audit
- Suivi du pourcentage de conformité
- Passer jusqu'à 100%
- Passer en Enforce
- Continuer d'ajouter de nouvelles Policies
<!-- .element: class="list-fragment" -->

##==##
<!-- .slide: data-background="./assets/techready/bkgnd.png"-->
### Sécurisation minimale et standard
- Kubernetes Propose de Pod Security Standard (par annotations)
- Kyverno propose un helm chart kyverno-policies (Implémentations par policies)
<!-- .element: class="list-fragment" -->


