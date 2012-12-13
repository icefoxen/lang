/* Desk calculator parser for ocamlyacc */
%token <int> INT
%token PLUS MINUS TIMES DIV
%token EOL
%token LPAREN RPAREN
%left PLUS MINUS /* Lowest precedence */
%left TIMES DIV  /* Medium precedence */
%nonassoc UMINUS
%start main
%type <int> main

%%

main: expr EOL { $1 };

expr:
   INT                          { $1 }
 | LPAREN expr RPAREN           { $2 }
 | expr PLUS expr               { $1 + $3 }
 | expr MINUS expr              { $1 - $3 }
 | expr TIMES expr              { $1 * $3 }
 | expr DIV expr                { $1 / $3 }
 | MINUS expr %prec UMINUS      { - $2 };
