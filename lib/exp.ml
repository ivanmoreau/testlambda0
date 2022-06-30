type t =
| Var of string
| Call of t list

type lExp =
  | BVar of int * string
  | App of lExp * lExp
  | Fun of string * lExp

let rec lexp_str : lExp -> string = function
| BVar (_, m) -> m
| App (e, e') -> "(" ^ lexp_str e ^ " " ^ lexp_str e' ^ ")"
| Fun (n, e) -> "λ" ^ n ^ " -> " ^ lexp_str e

let rec frep x e c = match e with
| BVar (_, na) when na = x -> BVar (c, na)
| App (e, e') -> App (frep x e c, frep x e' c)
| Fun (n, e) -> Fun (n, frep x e @@ c + 1)
| other -> other

let rec genfn : string list * lExp * int -> lExp = function
| (x :: []), e, c -> Fun (x, frep x e c)
| (x :: xs), e, c -> genfn (xs, Fun (x, frep x e c), c + 1)
| [], _, _ -> BVar (-1, "ERROR")

let rec handleApp e = match e with
| x::y::xs -> handleApp @@ App(x,y)::xs
| x::[] -> x
| _ -> failwith "Error"

let rec to_string = function
| Var s -> "Var(" ^ s ^ ")"
| Call xs ->
    let s = List.map to_string xs |> String.concat " " in
    "Call(" ^ s ^ ")"
