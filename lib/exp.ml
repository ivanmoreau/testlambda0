type lExp =
  | BVar of int * string
  | App of lExp * lExp
  | Fun of string * lExp

let rec lexp_str : lExp -> string = function
| BVar (n, m) -> m ^ "[" ^ string_of_int n ^ "]"
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

let handleNat n = let rec f n = match n with
| 0 -> BVar(0, "x")
| n -> App(BVar(1, "f"), f @@ n - 1) in
  Fun("f", Fun("x", f n))


