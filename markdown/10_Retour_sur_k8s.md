<!-- .slide: class="transition-bg-sfeir-2" -->
# Revenons à kubernetes 

##==##
<!-- .slide: class="transition-bg-sfeir-2" -->
## Le control-plane
![h500](./assets/kubernetes/k8s_archi1.png)
Notes:
Kubernetes est un orchestrateur de container piloté via APIs <BR>
Les requêtes sont émises par : 
- kubectl (outil CLI officiel)
- curl
- un outil tiers (k9s, headlamp, argoCD, ...)

##==##
<!-- .slide: class="transition-bg-sfeir-2" -->
## La requête est modélisée YAML
![h500](./assets/kubernetes/pod-yaml.png)

Notes:
- ses données (sous forme de yaml ou json)
  - son chemin d'appel (apiVersion)
  - l'objet concerné (kind)
  - les données à transmettre (specs)
- Le verbe d'action (CRUD) traduit en verbe HTTP (POST, PUT, PATCH, DELETE, GET)


##==##
<!-- .slide: class="transition-bg-sfeir-2" -->
## La requête est soumise avec les verbes HTTP
![h500](./assets/techready/CRUD.png)
Notes:
- Le verbe d'action (CRUD) traduit en verbe HTTP (POST, PUT, PATCH, DELETE, GET)
- GET
- POST
- PUT
- PATCH
- DELETE

##==##
<!-- .slide: class="transition-bg-sfeir-2" -->
## L'outil clef : l'Admission Controller

![h500](./assets/images/admission_schema.jpg)


##==##
<!-- .slide: data-background="./assets/techready/bkgnd.png"-->
<div class="full-center">
    <img src="./assets/techready/police-kyverno.png">
</div>



##==##
<!-- .slide: class="transition-bg-sfeir-2" -->
## Implémentation du Controller 
![h500](./assets/kubernetes/admissionReview.webp)


Notes: 
Control-plane starting parameter  - ou - CRD webhook registration

Puis l'enregistrer via l'apiVersion admissionregistration.k8s.io/v1 <BR>
ValidatingWebhookConfiguration ou MutatingWebhookConfiguration

