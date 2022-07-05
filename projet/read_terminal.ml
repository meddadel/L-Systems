open Read_files
open Turtle
open Graphics
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
(*Demande le nom du fichier que l'utilisateur souhaite ouvrir et renvoie le
Lsysteme correspondant*)
let rec recup_syst_fich () =
	print_string "Indiquez le chemin du fichier qui contient le L-system voulu\n";
 	let str = read_line() in
		try
			from_fich_to_syst str
		with
		| Sys_error _ | Failure _ ->
	print_string "Veuillez choisir un fichier valide\n";recup_syst_fich ();;
(*Cree un fichier au format sys avec l'axiome, les regles et les interpretations
en argument *)
let creation_fich ax ru inter =
	let fich = open_out ".creation_fich" in
		output_string fich ax;
		output_string fich "\n\n";
		(*Boucle qui ecrit la liste des regles et des interprétation dans le
		fichier avec un retour chariot entre chacun*)
		let rec loop l =
			match l with
			| [] -> output_string fich "\n";
			| r::l' -> output_string fich r; output_string fich "\n"; loop l'
			in
			loop ru;
		loop inter;
		close_out fich;;
(*Recupere un Lsyteme donne par l'utilisateur via la ligne de commande
Cette fonction se relance si le Lsysteme fourni n'est pas valide*)
let rec recuperer_syst_read () =
	print_string "Donnez l'axiome de votre Lsystems :\n";
	let ax = read_line() in
	print_string "Donnez les regles du Lsystems (tapez '-1' quand vous avez fini)\n";
	print_string "Elles doivent etre sous la forme :\n";
	print_string "'s w où s est le symbole dont w est la substitution de s\n";
	(* Boucle pour recuperer soit la liste des régles ou des interprétations
	qui s'arrete dès qu'on tape -1 *)
	let rec loop i acc =
		if (i = (-1)) then List.rev acc
		else
			let r = read_line() in
			let j =
				try
					int_of_string r
				with
				| Failure _ -> 0
				in
					if (j = -1) then loop j acc
					else
						loop j (r::acc)
	in
	let ru = loop 0 [] in
	print_string "Donnez les interprétations du Lsystems (tapez '-1' quand vous avez fini)\n";
	print_string "Elles doivent etre de la forme :\n";
	print_string "s cmd ou s est le symbole que vous souhaitez a cmd, qui peut être :\n";
	print_string "Tn pour Turn n,Mn pour Move n ou Ln pour Turn n avec n entier\n";
	let inter = loop 0 [] in
	(*Une fois l'axiome, les regles et les interpretations recuperes, on les copie
	dans le fichier ".creation_fich" puis on appelle from_fich_to_syst pour
	obtenir le Lsysteme correspondant *)
		creation_fich ax ru inter;
		try
		from_fich_to_syst ".creation_fich"
		with Failure _ | Interpretation_Invalide ->
		begin
		print_string "Vous avez donne un Lsysteme invalide\nVeuillez recommencer\n";
		recuperer_syst_read()
		end;;


(*Récupere la touche presse par l'utilisateur, avec en argument la dernière
position.
Si cette touche est different de 'a', 'r', 'q', '-' , '+', 'g','d', 'b' ou 'h'.
On rappelle la fonction jusqu'a que l'une de ses touches soit tapee
par l'utilisateur. Sinon on envoie l'action representant ce que veut
l'utilisateur*)
let rec recuperer_touche_utilisateur pos =
	let pos_int = int_int_of_float_float (t_pos_to_pos pos 0) in
	moveto 0 100;
	let s = "Appuyez sur A pour avancer d'une iteration,  R pour reculer," ^
	" Q pour quitter la fenetre et le programme, ou" in
	draw_string s;
	moveto 0 80;
	draw_string "+/- pour agrandir/reduire l'image ou ";
	moveto 0 60;
	draw_string ("B pour la descendre, H pour la monter," ^
	"G pour la decaler a gauche ou D pour la decaler a droite");
	let e = wait_next_event [Key_pressed] in
	moveto (fst pos_int) (snd pos_int);
	match e.key with
	| 'A' | 'a' -> Avancer
	| 'R' | 'r' -> Reculer
	| 'Q' | 'q' -> Quitter
	| '+'  -> ZoomAvant
	| '-' -> ZoomArriere
	| 'G' | 'g' -> DecaleGauche
	| 'D' | 'd' -> DecaleDroite
	| 'H' | 'h' -> DecaleHaut
	| 'B' | 'b' -> DecaleBas
	| _ -> recuperer_touche_utilisateur pos;;
(*Affiche le menu pour choisir entre les differentes options pour recuperer le
système, à savoir soit via un fichier, soit via l'invite de commandes*)
let rec menu_bienvenue () =
	print_string ("Bienvenue\n"
	^ "A partir de quel source voulez-vous fourni le L-Systeme ?\n" ^
	"Tapez 1 pour un fichier au format .sys ou 2 pour le fournir via l'invite
	de commande\n");
	let choix = read_line() in
		let n =
		try
		 	int_of_string choix
		with Failure _ -> 0
		in
			match n with
			| 1 -> recup_syst_fich()
			| 2 -> recuperer_syst_read()
			| _ -> menu_bienvenue ()
