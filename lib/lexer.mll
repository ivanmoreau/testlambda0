let whitespace = [' ' '\t' '\n']
let char = ['a'-'z' 'A'-'Z' '+' '-' '*' '/' '<' '>' '=' '!' '?' '_']
let letter = ['a'-'z' 'A'-'Z']
let identifier = letter+

rule f = parse
  | whitespace* { f lexbuf }
  | "(" { Parser.LPAREN }
  | ")" { Parser.RPAREN }
  | "\\" { Parser.FUN }
  | "λ" { Parser.FUN }
  | identifier as s { Parser.VAR s }
  | "," { Parser.COMMA }
  | "." { Parser.TO }
  | "->" { Parser.TO }
  | eof { EOF }
