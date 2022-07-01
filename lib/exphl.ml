

type stmt =
  | Data of (string * int) list
  | Fun of string * expr
  | Inline of string * expr
and expr =
  | Lam of (string list) * (expr list)
  | Match of expr * matcher
  | App of string * (expr list)
  | Var of string
  | Let of string * expr
  | Ret of expr
and matcher = 
  | Matche of (string * expr) list

type program = Program of stmt list


