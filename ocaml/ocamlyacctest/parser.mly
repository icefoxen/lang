/* Testing an ocaml parser/lexer stuff. */

%token <int> INT
%token PLUS MINUS TIMES DIVIDE
%token LPAREN RPAREN
%token EOL
%left PLUS MINUS    /* Lowest prescedence */
%left TIMES DIVIDE  /* Med. pres. */
%nonassoc UMINUS    /* Highest    */

%start main
%type <int> main

%%

main:
   expr EOL		{ $1 }

expr:
   INT			{ $1 }
 | LPAREN expr RPAREN	{ $2 }
 | expr PLUS expr	{ $1 + $3 }
 | expr MINUS expr	{ $1 - $3 }
 | expr TIMES expr	{ $1 * $3 }
 | expr DIVIDE expr	{ $1 / $3 }
 | MINUS expr %prec UMINUS	{ - $2 }
   ;
