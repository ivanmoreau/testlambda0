
let whitespace = [' ' '\t' '\n']
let letter = ['a'-'z' 'A'-'Z' '_']
let uCase = ['A'-'Z']
let lCase = ['a'-'z']
let identifier = lCase (letter+)
let constructor = uCase (letter+)
let nat = ['0'-'9']+

rule f = parse
  | whitespace* { f lexbuf }
  | "fn" { Parserhl.FUN }
  | "data" { Parserhl.DATA }
  | "match" { Parserhl.MATCH }
  | "inline" { Parserhl.INLINE }
  | "let" { Parserhl.LET }
  | "(" { Parserhl.LPAREN }
  | ")" { Parserhl.RPAREN }
  | "{" { Parserhl.LBRACE }
  | "}" { Parserhl.RBRACE }
  | "," { Parserhl.COMMA }
  | ";" { Parserhl.SEMICOLON }
  | "=>" { Parserhl.TO }
  | "=" { Parserhl.EQ }
  | nat as s { Parserhl.NAT (int_of_string s) }
  | identifier as s { Parserhl.IDENT s }
  | constructor as s { Parserhl.CONST s }
  | eof { EOF }
