(** Words, rewrite systems, and rewriting *)
open Turtle
open Graphics
type 's word =
  | Symb of 's
  | Seq of 's word list
  | Branch of 's word

type 's rewrite_rules = 's -> 's word

type 's system = {
    axiom : 's word;
    rules : 's rewrite_rules;
    interp : 's -> Turtle.command list }

(*Types pour representer l'arbre utilise pour l'Interpretation a la volee*)
type 's foret =
	| Foret of 's arbre list
and 's arbre =
	| Node of 's foret * 's

(*Prend une chaine de caractère et renvoie la liste des caractères présents
dans cette chaine*)
let split_str s =
	let len = String.length s in
		let rec aux acc n len =
			if (n = len) then List.rev acc
			else
				let char_cour = String.get s n in
					aux (Char.escaped char_cour::acc) (n+1) len
		in
		aux [] 0 len
(*Renvoie la chaine de caractère correspondant à l'instance word en argument*)
let rec from_word_to_str w =
 	match w with
	| Symb a -> a
	| Seq l -> List.fold_left (fun a s -> a ^ from_word_to_str s) "" l
	| Branch b -> "[" ^ from_word_to_str b ^ "]"
(*Renvoie l'arbre correspondant a l'axiome du lsysteme en argument *)
let arbre_ax lsyst =
	let l_list = split_str (from_word_to_str lsyst.axiom) in
	 	Node(Foret(List.map (fun x -> Node(Foret([]),x)) l_list),"")
(*Renvoie l'arbre correspondant a l'iteration suivante de l'arbre en argument
dans le L-Systeme lsyst *)
let rec next lsyst a =
	match a with
	| Node (f, s) ->
		begin match f with
		| Foret ([]) ->
			let l_s = split_str (from_word_to_str (lsyst.rules s)) in
				Node (Foret (List.map (fun s -> Node (Foret ([]), s)) l_s),s)
		| Foret (l) ->
				Node(Foret (List.map (fun n -> next lsyst n) l), s)
		end
(*Renvoie la n-ième itération du lsysteme en argument*)
let iteration n lsyst =
	let arbre = arbre_ax lsyst in
		let rec loop n t =
			if (n = 0) then t
			else
				loop (n-1) (next lsyst t)
		in
		loop n arbre
(*Renvoie la commande a effectuer par rapport à la chaine de caractere correspondant
 au mot voulu*)
let exec s l_pos lsyst =
	match s with
	| "[" -> Store
	| "]" -> Restore
	| _ -> List.hd (lsyst.interp s);;
(*Exécute la commande cmd a la position renseignee dans le premier element
dans l_pos et renvoie la nouvelle liste de position*)
let exec_cmd cmd l_pos =
	let pos = List.hd l_pos in
		let pos_int = t_pos_to_pos pos 0
		in
		match cmd with
		(* Si la commande est Move ou Line, on l'exécute, puis on remplace la
		tete de la liste par la nouvelle position courante*)
		| Move n | Line n ->
			let new_pos = t_pos_to_pos pos n in
				let new_pos_int = int_int_of_float_float new_pos in
					(line_or_move cmd) (fst new_pos_int) (snd new_pos_int);
					(pos_to_t_pos new_pos pos.a)::(List.tl l_pos)
		(* Si la commande est Turn, on remplace le premier element de l_pos
		par le premier element avec l'angle renseigne*)
		| Turn a ->
			((pos_to_t_pos pos_int (pos.a + a))::(List.tl l_pos))
		| Store ->
		(*Si la commande est Store, on ajoute la position courante a la liste*)
			(pos_to_t_pos pos_int pos.a)::l_pos
		(*Si la commande est Restore, on renvoie la liste sans sa tete*)
		| Restore -> List.tl l_pos
(*Execute les commandes relatives a l'arbre en argument et aux positions
de la liste l_pos et renvoie la liste des positions stockées*)
let rec exec_syst a pos lsyst =
	match a with
	| Node(Foret([]),s) ->
		let cmd = exec s pos lsyst in
				exec_cmd cmd pos
	| Node(Foret(n::l),s) ->
		let l_pos = exec_syst n pos lsyst in
				if (l <> []) then
				 exec_syst (Node(Foret(l),s)) l_pos lsyst
				else
					l_pos
