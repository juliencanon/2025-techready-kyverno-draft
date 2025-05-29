
✅ changer slide 1 : nom / société / date 
✅ Mieux placer Kyverno (IA ?) et l'horloge Chronomètre)
✅ changer slide 3 : speaker pro
✅ changer slide 4 : speaker perso


⌛️ Contexte : illustration sur Kubernetes
- Contexte 2 : cas typique deployment (?)
✅ Illustration Etoile Noire : beau cluster
- Realité : celerité, time to market, ... -> illustration chatGPT + bullet point fragments + entropie (minions)
  - appartenance des pods (labels, calcul des couts) , requests / limits, privilege escalation, nomenclature, origine des images..
- Bonnes pratiques : shift left, CI et TNR, devops, scans, ... gitops -> illustration (?)
- Malgré la sécurisation en amont, pas suffisant, dégradation du cluster en aval
-- supprimer les slides en doublon
- anecdotes du pourquoi : stagiaire, quick win, oublie (sortie du backlog, depriorisation, ...)


Relancer RAISE pour m'expliquer la gouvernance
- Conformité : definition
- liste des uses case (raise)
   - gouvernance
   - securité
   - bonnes pratiques
   - 
- exemple de référentiels (kyverno, nist, ...)
- slide endormissement

- kubernetes under the hood - pas tout revoir, mais "où les bactéries attaquent"
- big picture
- requete yaml (moins de texte) 
- admission controller (ilusatration ?) (slide doublon) (pas kyverno à ce stade)
- controller k8s, controller custom, webhook à implémenter et enregistrer
- historique : gatekeeper (2017, CNCF le... Rego.) / Kyverno (2018 ? CNCF le... Yaml) / Vap/Map (k8s, 2021, CEL) / Pivot Gatekeeper et Kyverno sur VAP et CEL 

- Démo installation kyverno
- Démo simple kyverno et blocage de resource (avant / après)

- Kyverno boîte à outils 
- Validation et Mutation (illustrer des use-cases) (registry autorisée)
- Autre : clean
- Autre : Image validation : signature, scan securité et attestation... notary, cosign
- Autre : Auto-gen (coup de génie)
   - Démo : policy pod + montrer autogen dans describe + test deployment pod
- Autre : Generation de nouvelle resource 
   - Démo : Namespace (netpol ou quota), Deployment (pdb ou hpa)
- Autre : Namespace exclusion et Policy exception
- Audit : backgrouneScan policyreports et UI policy reporter (+ server-reports en v0.2)
  - Démo : policy reporter (ou copie d'écran)
- Autre : CLI 
  - apply
  - test (en ligne ou en CI/CD pipeline)
  - convert ?? -> generation VAP ?
  - documentation

- Illustration dynamite, exploser le game
Remerciements (orga et sponsors)
Questions/réponses + Offical QR Code feedback TechReady







Auto-gen policy
gen resources
gen documentation
gen VAP transparent


Take away : 
- boite à outils
- gérer les bonnes pratiques en amont
- pas la pour faire la police (coût), mais plutôt pour garantir certaines règles (et non regression)
- utile pour l'audit
- composant sensible et stratégique (webhook / pas uniquement kyverno) -> HA , intree, ..



Feedback Négatifs (en vue d'une amélioration) :
- posture / gestuelle
- oral : tic de langage, fin de phrase, débit de parole, autre 
- slides sur la forme (illustrations, texte, police, couleurs, ...)
- slides sur le fond
- démos
- tout autre idée qui vous a traversé l'esprit
- rôle / blague pourries / 


Oral / Transcript : 
- Relire à l'oral
- Chronométrer
- Alimenter les notes de bas de page
- Générer PDF (secours)
- Générer site statique 


Démos : 
- Avoir une application de démo 




