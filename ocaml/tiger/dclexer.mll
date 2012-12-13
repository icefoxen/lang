(* Sample ocamllex program, for a desk calculator *)

(* Header, arbitrary code *)
{
open Parsing (* the type token is defined in parsing.mli *)
exception Eof
}

rule token = parse
   [' ' '\t']   { token lexbuf }  (* Skip blanks *)
 | ['\n']       { EOL }
 | ['0'-'9']+   { INT( int_of_string( Lexing.lexeme lexbuf ) ) }
 | '+'          { PLUS }
 | '-'          { MINUS }
 | '*'          { TIMES }
 | '/'          { DIV }
 | '('          { LPAREN }
 | ')'          { RPAREN }
 | eof          { raise Eof }
