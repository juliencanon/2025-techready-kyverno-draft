<!-- .slide: class="flex-row center" data-background="./assets/techready/bkgnd.png"-->
### Contexte Kubernetes
![h-500](./assets/techready/Deployment-crop.png)
![h-500](./assets/techready/Deploiment-workloads-k8s-2.png)
![h-500](./assets/techready/nuage-de-mots1.png)

##==##
<!-- .slide: class="flex-row center" data-background="./assets/techready/bkgnd-demo-title2.png"-->
### Création de notre cluster de démonstration
colima/docker + minikube

##==##
<!-- .slide: class="flex-row center" data-background="./assets/techready/bkgnd.png"-->
### Habemus Kubernetes Cluster
![h-1200](./assets/techready/belle-star3.png)
 
##==##
<!-- .slide: data-background="./assets/techready/bkgnd.png"-->
![h-500](./assets/context/minions.png)
#### Le concept plaît et est vite adopté en entreprise
- Les équipes déploient des microservices
- Il faut respecter le time to market
- On démarre en production et on implémente le SRE  
- Tout semble parfait dans le meilleur des mondes...
<!-- .element: class="list-fragment" -->

##==##
<!-- .slide: data-background="./assets/techready/bkgnd.png"-->
### Au royame du Time to Market
![h-800 center](./assets/techready/stress-celerite.png)

##==##
<!-- .slide: class="flex-row center" data-background="./assets/techready/bkgnd.png"-->
![h-500](./assets/context/minions2.webp)
#### L'entropie du système augmente...
- La définition des requests/limits manquent pour le CPU et la RAM
- Il est difficile de savoir à qui appartient telle ou telle application
- Les containers ne sont pas sécurisés (possibilité d'évasion)
- Les images proviennent de diverses registries, parfois obscures
- Une nomenclature serait la bienvenue
<!-- .element: class="list-fragment" -->

##==##
<!-- .slide: data-background="./assets/techready/bkgnd.png"-->
### Cadre méthodologique 
#### La base : continuer de sécuriser en amont
- Pratiques devops
- CI/CD
- Pratiques devsecops
- Fail fast
- Shift left
- Roue de Deming
- Tests unitaires, non regression
- Qualité du code
- Analyse Sécurité statique et dynamique
<!-- .element: class="list-fragment" -->



##==##
<!-- .slide: class="flex-row center" data-background="./assets/techready/bkgnd.png"-->
### ... mais l'état du cluster se dégrade inévitablement !
![h-1200](./assets/techready/sale-star2.png)


