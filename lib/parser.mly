%token <string> VAR
%token <int> NAT
%token FUN
%token TO
%token COMMA
%token SEMICOLON
%token LPAREN
%token RPAREN
%token EOF

%start <Exp.lExp> f

%%

f : e = expr; EOF { e }

expr :
  | es = nonempty_list (app); { Exp.handleApp es }

app : 
  | s = VAR; { Exp.BVar (-1, s) }
  | s = NAT; { Exp.handleNat s }
  | s = lam; { s }
  | LPAREN; es = expr ; RPAREN { es }

lam :
  | FUN; args = nonempty_list (VAR); TO; e = expr; { Exp.genfn(args, e, 0) }
