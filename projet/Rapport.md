### Equipe
L'équipe pour ce projet est constituée de:
* HAMDANI Harris hamdanih 22014430
* DJELLOUL ABBOU Mohammed Adel djelloul 22018734

### Fonctionnalités

Les fonctionnalités implémentées sont les suivantes :
- Lecture d'un L-Systeme via un fichier
- Lecture d'un L-Systeme via l'invite de commande
- Interprétation à la volée
- Possibilité d'agrandir / réduire la représentation du L-système à l'aide des touches "+" et "-".
- Possibilité de déplacer l'image vers le haut(H),vers le bas(B), vers la gauche(G) et vers la droite(D).
En somme, presque tout le sujet minimal a été traité, mis à part le calcul des bornes automatiques.


### Compilation et exécution

La compilation s'effectue via la commande `make` et l'exécution est lancée avec la commande `./run` sans argument.
Au moment de l'exécution, le programme vous demandera via quel moyen souhaitez-vous lui fournir le L-Système.
Vous aurez alors le choix d'importer votre L-Système via un fichier ou via l'invite de commande.
Après cela, si c'est le fichier a un format valide ou que le L-système fourni via la terminal est valide, on affiche l'axiome de L-système correspondant.
* Puis, selon les touches tapées par l'utilisateur sur la fenêtre, le programme effectuera différentes actions :
	* `A` -> avancer d'une itération pour le L-système correspondant
	* `R` -> reculer d'une itération pour le L-système correspondant
	* `+` -> agrandir l'image de l'itération courante
	* `-` -> rétrécit l'image de l'itération courante
	* `G` -> décaler l'image de l'itération vers la gauche
	* `D` -> décaler l'image de l'itération vers la droite
	* `H` -> décaler l'image de l'itération vers le haut
	* `B` -> décaler l'image de l'itération vers le bas
	* `Q` -> Ferme la fenêtre et arrête le programme.

On répète cette opération jusqu'à que l'utilisateur tape `Q`. Avant de s'arrêter, le programme écrit un message d'au revoir sur le terminal.

### Découpage modulaire

Le projet contient de nombreux modules dont nous allons vous préciser l'utilité:
- `Turtle` : module gérant les commandes et les positions dans les L-systèmes.
- `Systems` : module gérant les L-systèmes, en général, faisant appel à `Turtle`, pour tout ce qui est commande et position.
- `Read_files` : module permettant de récupérer d'un fichier des informations pour créer un nouveau L-système. Ce module est bien évidemment indispensable, pour pouvoir créer un L-système à partir d'un fichier.
- `Read_terminal` : module gérant la relation du programme avec le terminal, à savoir la récupération du nom du fichier ou du L-Système et l'action voulue par l'utilisateur sur le L-Système courant. Ce module est nécessaire pour pouvoir récupérer et interpréter les actions voulues par l'utilisateur.

### Répartition du travail

 Pour ce projet, on a réfléchi tous les deux sur la partie lecture d'un L-Système à partir d'un fichier ou du terminal. La partie sur les L-systèmes,à proprement parlé, a été réalisée par Harris, tout comme la partie Turtle ou encore celle sur la partie plus graphique du projet.  

 En ce qui concerne la chronologie du travail sur ce projet, on peut mettre en évidence 2 phases :
 * Le mois de novembre et début décembre
 * Début janvier.

Le "reconfinement" de novembre nous a permis de découvrir le sujet et de nous familiariser avec les L-systèmes, les tortues et autres concepts explorés dans ce projet.
Puis, après un mois de décembre rempli de révisions pour les examens, de Devoirs Maison ou encore de projets à rendre, on s'est remis au travail au début du mois de janvier, une fois ces tempêtes passées. On a pu alors s'attaquer à la lecture des fichiers et du terminal, afin de récupérer les L-Systèmes de l'utilisateur et d'interpréter à la volée les L-Systèmes. De plus, l'affichage a été corrigée, afin d'être plus lisible, et gérée par l'utilisateur.
