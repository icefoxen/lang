type token =
  | INT of (int)
  | PLUS
  | MINUS
  | TIMES
  | DIVIDE
  | LPAREN
  | RPAREN
  | EOL

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> int
