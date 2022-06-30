let () = print_endline "Hello, World!"
let () = print_endline "HOHOOHOHOHO"
let () =
  print_endline @@
  Lambda.Exp.lexp_str @@
  Lambda.Parser.f Lambda.Lexer.f @@
  Lexing.from_string @@
  "(test a b c) \\a -> sd"
