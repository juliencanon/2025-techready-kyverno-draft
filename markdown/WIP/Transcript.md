Réunion démarrée à 2025-05-12 13:12 UTC+2


Bonjour à tous,
Vous allez bien ?
Je n'ai rien entendu, vous allez bien ?
Merci d'être venu pour cette conférence.
Installez vous bien, j'ai 40 minutes pour vous dire que Kyverno c'est de la dynamite !
  (En espérant que vous aurez la ref)

Tout d'abord, je me présente : Julien Canon, Architecte Cloud chez Sfeir.
Je travaille sur les 3 hyperscalers Américain et aussi beaucoup sur Kubernetes.
Et c'est dans ce contexte, afin de vérifier que nos référentiels étaient bien pris en compte sur le terrain, que j'ai commencé à utiliser Kyverno.

ça c'est pour le côté professionnel. Dans la vie de tous les jours, je suis un papa geek fan de robotique, de casse-tête, de running et autres...

Maintenant que je me suis présenté, j'aimerai en savoir un peu plus sur vous.
J'espère que vous connaissez l'orchestrateur kubernetes, sinon ça risque de piquer un peu
- à main levé, qui est plutôt venir pour le cas d'usage de la conformité dans les clusters ?
- Et qui est plutôt instéressé par l'aspect technique de kyverno et une démo ?

OK.
Eh bien allons-y, notre histoire se déroule dans le contexte de kubernetes.
Commençons par un rappel sur ce que c'est.
Donc c'est un contrôleur de c'est un orchestrateur de conteneur qui où l'entité de base est le pod euh donc avec un ou plusieurs conteneurs dedans et on a un certain nombre de patterns.
Le plus utilisé est dans le déploy déployment qui permet de déployer une grappe de de pod d'application et assurer la résilience et l'équilibrage de charge.
Ensuite, on a des stateful des stateful 7 qui permettent de gérer des des work plus complexes avec la gestion de d'état comme typiquement des bases de données ou des IHM stateful et puis la marche en fait des chron
jobs quoi.
Des jobs des cron jobs pour qui sont fixés sur horaire et cetera.
On a plein d'autres outils hein des network polici qui font un peu le firewall au sein de du réseau pour bien test.
Euh on a des des services pour l'accès le dis l'aspect discovery et des ingress pour le routage au niveau 7. Donc j'espère que tout ça c'est un peu connu, sinon le reste de la présentation peut piquer.
Euh ce qui va nous intéresser principalement c'est la partie de l'admission contrôleur.
En fait, quand donc sur QnetS tout est API, tout est tout est sous forme d'API et à tel point que les ressources sont décrite sous forme d'un fichier Yamel avec le groupe qu'elle appartient à la PI, le la
ressource en question, le type de ressource, le kind on appelle ça et euh toutes les spécifications de la requête.
Donc c'est bien, c'est un fichier Yamel, c'est le le fichier qu'on retrouve en data dans la requête et donc ça passe via le contrôle play.
Euh donc la la pierre angulaire de ce qui va nous intéresser, c'est d'où le le zoom sur cette fonctionnalité, c'est le pipeline d'entrée.
Donc en fait la requête quand la requête arrive sur le contrôle plan, elle est d'abord authentifiée.
Donc il a on passe l'autorisation qui permet de vérifier si la personne pour avoir l'identité de la personne ou du service quoi l'identité de la requête, savoir à partir de cette identité là si elle est autorisée ou non.
Et ensuite, on a une première une première étape qui est le mutation controller qui permet de éventuellement à la volée de modifier la requête.
C'estàdire on peut élaguer des parties qui nous intéressent pas, qui sont soit dangereuses, soit non souhaitables.
On peut rajouter euh des champs et on peut modifier des champs existants.
Voilà.
Donc on a une étape de modification qu'on utilise ou qu'on utilise pas.
Ensuite, une fois qu'on sait que la la c'est le dernier moment où la la requête est figée, on vérifie qu'elle valide le schéma.
Ça c'est une épéante pour pas casser la suite.
Une fois que le schéma est validé, on a une deuxième étape qui va être très pratique pour nous, qui permet de décider si ou non on la prend.
Et voilà.
Donc Cuberneta sans lui-même a déjà des implément déjà ce type de contrôle, mais on peut rajouter étofer et rajouter nos propres contrôles.
00:05:00
Et à la fin, bah si elle a passé toutes les étapes, elle est sauvegardée dans la dans la dans etcd on sauve tout est sauvegardé.
Voilà.
Donc cette ce pipeline là est vraiment intéressant pour notre case qui est la conformité.
Donc qu'est-ce que la conform donc la conformité on va venir donc le le but c'est de pouvoir s'assurer que les différentes normes dans les différentes normes d'entreprise ou les référentiels de l'entreprise sont donc sont bien appliqué donc ça
les les idées ça peut simplement aller de convention de dommage de de ou de bonnes pratiques de de convention de dommage pratique des dédiées à l'entreprise.
Il faut trouver des bonnes pratiques, des référentiels de bonnes pratiques euh communautaires ou établi par des sociétés sur internet pour mieux cadrer le besoin.
On peut simplement avoir des problèmes de des problématiques de tagging pour tout ce qui est discovery, CMDB et cetera ou encore des règles de sécurité, d'implémentation et ça.
al j'espère que vous vous êtes pas endormi et on va faire un peu le lien avec ces deux étapes.
Alors les contrôleurs, les deux contrôleurs dont on a vu, on a parlé là en fait historiquement et ben alors je dis web logique web logique en en utilise déjà son ses propres outils donc il a déjà ses propres
contrôleurs écrit en go et l'idée de base si on veut l'étendre on peut nous aussi écrire des contrôleurs en go et venir les enregistrer dans les options du contrôleur.
euh dans les dans les options du contrôle play.
Donc ensuite euh par contre aller écrire du code à chaque fois, c'est un peu c'est un peu lourd et puis on pour pouvoir l'accrocher et le le rendre un peu plus dynamique parce que au lieu de mettre sur
le démarrage du contrôle plane, on l'autre est venue la notion de webbook.
Donc en fait là c'est plus simple parce qu'on on crée un webbook.
Donc en fait c'est une une fois de plus une API un composant tiersce qui récupère une sous forme d'API donc une requête qui est l'admission review qui permet de faire d'avoir tous les toutes les informations contenues dans un
seul Yamel.
On a on décide à partir d'admission review, on on décide si oui ou non quoi.
On on prend ou pas, on a tous les amendement et on renvoie une une admission de réponse.
Et pareil pour la mutation review, mutation réponse et c'est déjà plus simple mais ça reste des choses à coder.
Et donc euh afin de comme à chaque fois dans l'informatique quand on a quelque chose à implémenter et qu'on le fait souvent et ben on commence à faire un framework.
Et donc la le premier produit sur le marché qui a qui a permis ça, c'est pas KNO, c'est gatekeeper et qui s'est basé sur un moteur de policy qui s'appelle OPA, open policy agent.
Donc c'est un langage ouvert, open source et qui s'appelle le REGO.
OPA, donc l'agent OPA se base sur un langage qui s'appelle le REGO et qui a un langage d'évaluation d'expression vraiment très puissant.
Donc du coup, pourquoi pas s'en servir pour faire des expressions de sur les policiers ?
les policiernetes.
Donc l'outil a une fois qu'il est sorti en telle année et ben il est il a eu beaucoup de succès et parce que il y a très très vite une grosse adoption, une grosse communauté qui s'est plugué dessus.
Là où il atteint ses limites, c'est en terme de le la marche à franchir pour comprendre le pour être à l'aise en RGO pour savoir relire du Ro pour savoir les écrire soi-même et cetera.
Euh et l'autre point, on on pourrait y revenir plus tard mais c'est aussi la performance.
Donc c'est déjà très performant hein, mais on s'aperçoit qu'en fait finalement euh ça peut commencer à entraîner de la latence.
Il faut savoir que forcément on se met en coupure de tous les requêtes.
Donc si on est un peu lent, on euh on l'ensemble du contrôle plane.
Euh ensuite euh poursuivre l'appel.
Donc au sortir de ce de donc Kateekeper a a vraiment grossi très vite et cetera et on s qu'il y a une partie de de la population qui est pas couverte où en fait ce ce produit là est
un peu trop compliqué.
Donc c'est comme ça qu' est né le projet Kiverno en disant ben on va faire à peu près la même chose.
On c'est un copain quoi ou un cousin et demi comme vous voulez mais qui se veut plus simple et plus facile d'accès pour et donc c'est pas forcément pour prendre le terrain peut-être ou pas mais c'est surtout pour
00:10:00
simplifier l'accès.
Donc en fait il on il décide en fait de de pouvoir écrire ses policiers en Yamel et du Yamel brut vraiment juste Yamel pas de langage do et il propose donc une collection de de politiques à à télécharger
implémenter et ça commence à démarrer et cetera.
C'est un ça ça passe en début de la course à pied.
Mise en pause.
Arrêt de la course à pied.
Et donc du coup le euh ce donc ça s'appelle Kiverno et Kiverno donc propose principalement ce biais de pouvoir mettre des politiques euh en Yamel et on verra après.
et tant qu'à faire avoir une boîte à outil commence à proposer d'autres fonctionnalités, on pourra y revenir plus on y reviendra plus tard mais voilà ce stade, on peut dire que ça suffit.
Je vais refaire encore un dernier aparté, c'est sur un outil euh euh qui est sorti donc finalement un des un des autres points enfin c'est la casse, c'est-à-dire le si jamais le webbook ne répond pas, on est en
coupure et donc si et ben on bloque complètement le mécanisme de Q&T.
C'est-à-dire que les requêtes sont bloquées, ell au stade de l'admission, bah on peut pas appeler le Webbook, ça bloque et on n'est pas on n'est jamais enregistré dans dans E et TCD et la requête n'aboutit pas.
Donc pour ça euh le produit Cubernetes en lui-même a proposé une une autre alternative pour enrichir sa gamme avec des mutation avec des nouvelles ressources qui sont le mutation admission policy et le
mutation policy et validating admission policy.
Mutating admission policy et validating admission policy.
Et avec ces outils là, l'avantage c'est que c'est pas des webbooks, c'est des ressources que l'on crée dans dans Cubernetest et qui sont directement implémentées dans les contrôleurs au sein même de Cubnet, on appelle ça le intry.
Et euh et donc c'est à la fois performant et robuste parce que là on a en fait c'est fait par l'équipe et c'est pas un produit un produit tiers.
L'autre point qui a été d'intention, c'est que c'est policy.
Donc on a dit que le Yamel, ben ça prenait un certain temps par donc c'était encore moins performant que le REGO.
Donc on a ils voulaient combler la problématique de la performance et donc ils sont basés sur un langage de validation d'expression, donc moins puissant juste des expressions et très à la fois puissant et euh et simple.
Et donc il un autre langage open source qui a été conçu au départ pour des loot des reverse proxy des load balancer c'est le C command expression language.
Et donc déjà la syntaxe elle est quand même plus accessible que le le rogo et en plus les requêtes sont précilées dans le moteur et donc on tourne vraiment au niveau de la millisecondes microsecondes.
En fait c'est comme c'est comm pour les revers proxy c'est vraiment faut que ça dépotte et donc là c'est le combo gagnant c'est à la fois solide.
et euh et rapide et performant et relativement simple à maintenir et à écrire.
Et donc euh les aujourd'hui les outils comme Kernog Gekeper basculent dessus euh quo pivote et permett de travailler aussi avec ce langage.
Et voilà.
Donc on va on va nous aujourd'hui le but je me concentre à la fois sur la technique et sur la conformité.
Donc j'illustre tout avec Kverno qui pour moi euh est c'est complètement subjectif mais a pas mal d'avenir et a quand même propose beaucoup de fonctionnalité et cetera euh que je vais vous faire découvrir.
Donc pour commencer, je vais faire une première démonstration où on je vous montre un peu donc j'installe l'environnement.
Donc je crée donc je suis sur Mac donc il me faut un démon.
Donc j'ai Colima qui est l'équivalent de Docker.
J'installe un miniube et ensuite une fois que j'ai mon miniube euh je peux déployer euh déjà Kiver.
Donc voici la démo.
Je lance la démo.
Ensuite une fois que j'ai KNO, ben il faut une application.
Donc j'arrive en on a on est en en entreprise, on a déjà une première application à déployer.
00:15:00
Je la déploie.
Voilà, je prends le patent du déployment.
Euh quand même pour ça, je déploie une première appli sous forme de pode.
Bon, il se trouve que euh l'équipe sécurité me demande d'appliquer un certain nombre de règles.
Donc, ils me disent de pas utiliser le tag, ils me disent de sécuriser avec un security contexte et voilà.
Donc ben vu que j'ai commencé à mettre en place ces règles.
Je peux je vais les mettre en terme d'audit ce qui permet de par défaut quand même c'est ma prod il faut pas elle vaut mais le but c'est de pas casser la prod.
Donc je mets en en audit et on on peut voir le résultat au travers de policier report.
Donc je vous montre un petit peu comment ça ressemble de policier report.
Donc là, OK, je pense que je perds beaucoup de gens parce que c'est très technique, c'est très beaucoup de textes et cetera.
Donc la démo 3, je vais vous installer un un outil qui est fourni par Kiverno qui s'appelle le policier reporter et qui s'installe toujours à Mchart.
Donc je l'installe.
Voilà.
Et l'avantage, c'est que ça me donne accès à une interface.
L'interface euh elle donne des informations sur mon infra, sur mes potes, sur ma configuration.
Donc euh vous il faut pas la rendre accessible à l'extérieur.
Pour l'instant, elle est déployée, elle existe qu'à l'intérieur de mon cub.
Donc le plus simple, moi je suis en que je sois en local ou un cluster distant, le plus simple hein, c'est si j'ai accès via CUPCTL, je peux faire un port forward et j'ai accès dans le local.
Et voilà, je vous montre et on voit bah que pour l'instant effectivement les euh les polici sont pas sont pas bonnes.
D'accord.
Donc là comme ça, ça permet déjà de commencer à avoir un taux de conformité et on on a une bonne image de là où on en est.
Donc le on peut commencer soit à patcher euh les applications.
Bon moi je vais je peux les on peut les redéployer en fait en propre et je vais déployer une nouvelle application à côté qui vérifie.
On verra si c'est bon.
Et quand on arrive à un taux de compatibilité de 100 % ou approchant de 100 % en fait on peut commencer à mettre les policiers en en force.
Et à ce stade-là, même je je vois qu'elles sont de forcer mais il y a quelques-unes qui voudront passer outre et on a un outil qui s'appelle le la policy exception.
Et la policier exception permet de dire bon bah OK, j'ai une règle générale qui est imposée, j'ai une une un workload qui qui en toute légitimité ou parce que c'est pratique et qui prend pas on accepte le risque
et ben on va dire bon ok la règle s'applique sauf pour celui-là.
Après, j'ai d'autres fonctionnalités à vous montrer.
Tout tout d'abord l'autogénération de ressources, c'est pratique parce que là ben jusqu'ici en fait on a travaillé juste avec un pod mais en vrai euh on déplo rarement un tout seul he je vous l'ai dit on utilisait pas
terme de deployment et donc pour pour éviter de réécrire la règle pour des ployment pour des crunch job pour et cetera, en fait kiverno une des un des game changer quand même c'est on peut s'amuser à écrire et
cetera mais il le fait pour nous.
Donc autogénération des ressources et génération de des automatiquement donc autogène.
Ensuite après il y a les les gèes ressources après il y a les images et après il y a les VAP vaputation clean.
les images.
Donc ben je remercie beaucoup en tout cas les J'espère que ça vous a plu.
Je remercie tout d'abord Tech Teddy de m'avoir fait confiance.
Je vous avoue que c'était mon premier talk en public.
Voilà donc euh et je remercie tes crédit et tous les gens qui de près ou de loin m'ont aidé pour ce ton euh et euh je vous avoue donc du coup c'est mon premier TO sur une grande conférence
comme ça et donc à plus forte raison j'aurais vraiment besoin si vous pouviez passer un peu de temps pour me faire un feedback le plus constructif possible pour que je puisse améliorer les les quelques points qui qui auront
pas été et donc maintenant Si il nous reste un petit peu de temps, si vous voulez me poser des questions ou voilà, il me reste un petit peu de temps et sinon on va vous pouvez venir le voir
plus tard après le tablet.

Réunion terminée au bout de 00:20:02 👋


