open Graphics
type command =
| Line of int
| Move of int
| Turn of int
| Store
| Restore

type position = {
  x: float;      (** position x *)
  y: float;      (** position y *)
  a: int;        (** angle of the direction *)
}
(*Change une position en (x,y) en une position de type Turtle.position*)
let pos_to_t_pos (x,y) a =
 	{
		x = x;
		y = y;
		a = a;
	}
(*Convertit une paire de float en une paire de int*)
let int_int_of_float_float (x,y) =
	int_of_float x,int_of_float y;;
(*Convertit un angle en degre en radiant*)
let deg_to_radian n =
 	let a = n mod 360 in
		let a' =
			if(a < 0) then (float_of_int a) +. 360.
			else float_of_int a in
		a' /. 180. *. 3.1415927

(*Retranscrit la position indiqué par le type position dans la position "reelle"*)
let t_pos_to_pos pos n =
	let angle = deg_to_radian pos.a in
	((pos.x +. float_of_int n *. (cos angle)),
	(pos.y +. float_of_int n *. (sin angle)))
(*Fonction qui renvoie la fonction graphique à faire selon si la commande
est Line ou Move.*)
let line_or_move cmd =
 	match cmd with
	| Line _ -> lineto
	| Move _ -> moveto
	| _ -> failwith "line_or_move erreur"
