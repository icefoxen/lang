{
open Parser    (* The type Token is defined in parser.mli *)
exception Eof

}

rule token = parse 
   [' ' '\t']		{ token lexbuf } (* Skip blanks... *)
 | ['\n']		{ EOL }
 | ['0'-'9']+		{ INT( int_of_string( Lexing.lexeme lexbuf ) ) }
 | '+'			{ PLUS }
 | '-'			{ MINUS }
 | '*'			{ TIMES }
 | '/'			{ DIVIDE }
 | '('			{ LPAREN }
 | ')'			{ RPAREN }
 | eof			{ raise Eof }
