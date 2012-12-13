type token =
  | INT of (int)
  | PLUS
  | MINUS
  | TIMES
  | DIV
  | EOL
  | LPAREN
  | RPAREN

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> int
