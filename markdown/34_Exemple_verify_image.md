
<!-- .slide: class="flex-row center" data-background="./assets/techready/bkgnd.png"-->
<!-- .slide: class="transition-bg-sfeir-2" -->
# Policies Kyverno de type verify image

Notes:
Voici des exemples réels de policies Kyverno de type "verify image" utilisées dans des environnements Kubernetes :

##==##
<!-- .slide: class="with-code-dark max-height" data-background="./assets/techready/bkgnd.png"-->
### 1. Vérification des signatures d'images avec Cosign

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: verify-image-signatures
spec:
  validationFailureAction: Enforce
  background: false
  rules:
    - name: verify-cosign-signature
      match:
        resources:
          kinds:
            - Pod
      verifyImages:
      - imageReferences:
        - "registry.example.com/apps/*"
        attestors:
        - entries:
          - keyless:
              subject: "https://github.com/example-org/example-app/.github/workflows/build.yaml@refs/heads/main"
              issuer: "https://token.actions.githubusercontent.com"
```
Notes: 
Cette policy vérifie que les images provenant du registre spécifié sont signées avec Cosign et que la signature provient du workflow GitHub spécifié.

##==##
<!-- .slide: class="with-code-dark max-height" data-background="./assets/techready/bkgnd.png"-->
### 2. Vérification des images avec Notary

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: check-notary-signatures
spec:
  validationFailureAction: Enforce
  background: true
  rules:
    - name: verify-notary-signature
      match:
        resources:
          kinds:
            - Deployment
            - StatefulSet
      verifyImages:
      - imageReferences:
        - "docker.io/company/*"
        attestors:
        - entries:
          - keys:
              publicKeys: |-
                -----BEGIN PUBLIC KEY-----
                MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEHydAoBV6VqoK1SWjjwuS3t0JWd8B
                RJzKHXfJ9ZXfTQO5ZgdQSF5+QQUdMdQUxnlF3yFsQc1qsGkgJ0JywCDrDw==
                -----END PUBLIC KEY-----
```
Notes: 
Cette policy vérifie que les images du registre Docker Hub de l'entreprise sont signées avec la clé publique spécifiée.

##==##
<!-- .slide: class="with-code-dark max-height" data-background="./assets/techready/bkgnd.png"-->
### 3. Vérification des attestations de sécurité

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: verify-vulnerability-scan
spec:
  validationFailureAction: Enforce
  background: true
  rules:
    - name: verify-trivy-scan
      match:
        resources:
          kinds:
            - Pod
      verifyImages:
      - imageReferences:
        - "*"
        attestors:
        - entries:
          - keys:
              publicKeys: |-
                -----BEGIN PUBLIC KEY-----
                MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEyx9f56AgQfJkgvGzQg4dH3Lrja4W
                uEjwAYMg7gIQVqg2qkDKrOT3jy0hSG2cPOdQXeYgPC2kwCcgLQZDNwDPJw==
                -----END PUBLIC KEY-----
        attestations:
          - predicateType: cosign.sigstore.dev/attestation/vuln/v1
            conditions:
            - all:
              - key: "{{ vulnerability.results[?(@.vulnerabilities)].vulnerabilities[?(@.severity=='CRITICAL')] | length(@) }}"
                operator: LessThanOrEquals
                value: 0
```
Notes:
Cette policy vérifie que les images ont été scannées pour les vulnérabilités avec Trivy et qu'elles ne contiennent aucune vulnérabilité critique.

##==##
<!-- .slide: class="with-code-dark max-height" data-background="./assets/techready/bkgnd.png"-->
### 4. Vérification des images provenant de registres approuvés

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: verify-registry-and-signature
spec:
  validationFailureAction: Enforce
  background: true
  rules:
    - name: verify-trusted-registry-and-signature
      match:
        resources:
          kinds:
            - Pod
      verifyImages:
      - imageReferences:
        - "gcr.io/secure-project/*"
        - "registry.internal.company.com/*"
        attestors:
        - count: 1
          entries:
          - keys:
              publicKeys: |-
                -----BEGIN PUBLIC KEY-----
                MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEyx9f56AgQfJkgvGzQg4dH3Lrja4W
                uEjwAYMg7gIQVqg2qkDKrOT3jy0hSG2cPOdQXeYgPC2kwCcgLQZDNwDPJw==
                -----END PUBLIC KEY-----
```
Notes:
Cette policy vérifie que les images proviennent uniquement des registres approuvés et qu'elles sont signées avec la clé publique spécifiée.

##==##
<!-- .slide: class="with-code-dark max-height" data-background="./assets/techready/bkgnd.png"-->
### 5. Vérification des attestations de conformité SBOM

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: verify-sbom-attestation
spec:
  validationFailureAction: Enforce
  background: true
  rules:
    - name: verify-sbom-exists
      match:
        resources:
          kinds:
            - Deployment
      verifyImages:
      - imageReferences:
        - "*"
        attestors:
        - entries:
          - keys:
              publicKeys: |-
                -----BEGIN PUBLIC KEY-----
                MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEHydAoBV6VqoK1SWjjwuS3t0JWd8B
                RJzKHXfJ9ZXfTQO5ZgdQSF5+QQUdMdQUxnlF3yFsQc1qsGkgJ0JywCDrDw==
                -----END PUBLIC KEY-----
        attestations:
          - predicateType: https://spdx.dev/Document
```
Notes: 
Cette policy vérifie que les images déployées possèdent une attestation SBOM (Software Bill of Materials) signée avec la clé spécifiée, garantissant ainsi la transparence sur les composants logiciels utilisés.

