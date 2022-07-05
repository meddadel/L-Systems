
(** Turtle graphical commands *)
type command =
| Line of int      (** advance turtle while drawing *)
| Move of int      (** advance without drawing *)
| Turn of int      (** turn turtle by n degrees *)
| Store            (** save the current position of the turtle *)
| Restore          (** restore the last saved position not yet restored *)

(** Position and angle of the turtle *)
type position = {
  x: float;        (** position x *)
  y: float;        (** position y *)
  a: int;          (** angle of the direction *)
}

val pos_to_t_pos : float * float -> int -> position
val int_int_of_float_float : float * float -> int * int
val deg_to_radian : int -> float
val t_pos_to_pos : position -> int -> float * float
val line_or_move : command -> int -> int -> unit
