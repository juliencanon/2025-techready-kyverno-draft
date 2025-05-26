
<!-- .slide: class="transition-bg-sfeir-2" -->
## Enregistrement des controllers d'admission

Kubernetes recommende ces controllers par défaut

```
--enable-admission-plugins=NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,DefaultStorageClass
```
Ceux-ci sont ajoutés pour gérer les webhook via CRDs

```
--enable-admission-plugins=ValidatingAdmissionWebhook,MutatingAdmissionWebhook
```

Notes:
Référence : https://kubernetes.io/blog/2019/03/21/a-guide-to-kubernetes-admission-controllers/

