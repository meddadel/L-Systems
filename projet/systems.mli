(** Words, rewrite systems, and rewriting *)
type 's word =
  | Symb of 's
  | Seq of 's word list
  | Branch of 's word

type 's rewrite_rules = 's -> 's word

type 's system = {
    axiom : 's word;
    rules : 's rewrite_rules;
    interp : 's -> Turtle.command list }
(*Type arbre representant l'arbre permettant de realiser l'interprétation à la volée*)
type 's foret =
	| Foret of 's arbre list
and 's arbre =
	| Node of 's foret * 's
val next : string system -> string arbre -> string arbre
val arbre_ax : string system -> string arbre
val exec_syst : string arbre -> Turtle.position list -> string system -> Turtle.position list
val iteration : int -> string system -> string arbre
