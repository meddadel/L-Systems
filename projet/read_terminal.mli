open Systems
open Turtle
(* Module gérant la partie du programme en relation avec le terminal *)

(*Type indiquant le choix de l'utilisateur par rapport au L-systeme courant :
Avancer -> Avancer d'une iteration
Reculer -> Reculer d'une iteration
ZoomAvant -> Agrandir la representation du L-système
ZoomArriere -> Réduit la taille de la representation du L-système
DecaleGauche -> Decale l'image vers la gauche
DecaleDroite -> Decale l'image vers la droite
DecaleHaut -> Decale l'image vers le haut
DecaleBas -> Decale l'image vers le bas
Quitter -> Quitte le programme *)
type action =
	| Avancer | Reculer | ZoomAvant | ZoomArriere
	| Quitter | DecaleGauche | DecaleDroite | DecaleHaut | DecaleBas;;
val recuperer_touche_utilisateur : position -> action
val menu_bienvenue : unit -> string system
