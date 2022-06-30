%token <string> IDENT
%token <string> CONST
%token <int> NAT
%token DATA
%token FN
%token INLINE
%token MATCH
%token COMMA
%token TO
%token EQ
%token SEMICOLON
%token LET
%token LPAREN
%token RPAREN
%token LBRACE
%token RBRACE
%token EOF


%start <Exphl.Program> f

%%

f : e = nonempty_list(stmt); EOF { Exphl.Program e }

stmt :
  | DATA; LBRACE; e = data_body; RBRACE { Exphl.Data e }
  | INLINE; n = IDENT; EQ; e = expr; SEMICOLON; { Exphl.Inline(n, e) }
  | FN; n = IDENT; e = lambda; { Exphl.Fun(n, e) }

data_body :
  | xs = separated_nonempty_list(COMMA, data) { x :: xs }

data :
  | n = CONST; LPAREN; s = NAT; RPAREN { (n, s) }

lambda :
  | LPAREN; a = args; RPAREN; LBRACE; e = block; RBRACE { Exphl.Fun(a, e) }

args :
  | xs = separated_nonempty_list(COMMA, IDENT) { xs }

small_expr :
  | IDENT; 
