
open Lsystems (* Librairie regroupant le reste du code. Cf. fichier dune *)
open Systems (* Par exemple *)
open Turtle
open Graphics
open Examples
open Read_files
open Read_terminal

(** Gestion des arguments de la ligne de commande.
    Nous suggérons l'utilisation du module Arg
    http://caml.inria.fr/pub/docs/manual-ocaml/libref/Arg.html
*)
let usage = (* Entete du message d'aide pour --help *)
  "Interpretation de L-systemes et dessins fractals"

let action_what () = Printf.printf "%s\n" usage; exit 0

let cmdline_options = [
("--what" , Arg.Unit action_what, "description");
]

let extra_arg_action = fun s -> failwith ("Argument inconnu :"^s)
(* Fournit un système identique a celui en argument excepte l'interprétation
sur Line/Move n, en changeant l'argument n par op
*)
let reduire_syst syst op =
	let new_inter = fun x ->
		match (List.hd (syst.interp x)) with
		| Line n ->
			let new_n = (op n 2)  in
			if (new_n > 0)
			then [Line new_n]
			else [Line n]
		| Move n ->
			let new_n = (op n 2)  in
			if (new_n > 0)
			then [Move new_n]
			else [Move n]
		| _ -> syst.interp x
	in
	{syst with interp = new_inter}

let main () =
  Arg.parse cmdline_options extra_arg_action usage;
	let sys = menu_bienvenue () in
	open_graph " 800x800";
	(*On cree une boucle, qu'on arrete des que l'utilisateur tape q sur la fenetre*)
	let rec loop i syst x y =
		if (i = -1) then
		begin clear_graph(); close_graph(); end
		else
			let a_n = iteration i syst
			in
				moveto 250 10;
				draw_string ("Iteration " ^ string_of_int i);
				moveto (int_of_float x) (int_of_float y);
				let l_pos = exec_syst a_n [{x;y;a=0}] syst in
				let n = recuperer_touche_utilisateur (List.hd l_pos) in
				match n with
				| Avancer -> clear_graph();loop (i+1) syst x y
				(*Si on veut reculer, il faut que i > 0*)
				| Reculer when i <> 0 -> clear_graph();loop (i-1) syst x y
				| Reculer -> loop 0 syst x y
				| ZoomAvant ->
					clear_graph();loop i (reduire_syst syst ( * )) x y
				| ZoomArriere ->
					clear_graph();loop i (reduire_syst syst ( / )) x y
				| DecaleGauche ->
					clear_graph();loop i syst (x -. 50.) y
				| DecaleDroite ->
					clear_graph();loop i syst (x +. 50.) y
				| DecaleHaut ->
						clear_graph();loop i syst x (y +. 50.)
				| DecaleBas ->
						clear_graph();loop i syst x (y -. 50.)
				| Quitter -> loop (-1) syst x y
	in
		loop 0 sys 200. 200.;
	print_string "Au revoir";;

(** On ne lance ce main que dans le cas d'un programme autonome
    (c'est-à-dire que l'on est pas dans un "toplevel" ocaml interactif).
    Sinon c'est au programmeur de lancer ce qu'il veut *)

let () = if not !Sys.interactive then main ()
