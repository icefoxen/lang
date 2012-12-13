type token =
  | INT of (int)
  | PLUS
  | MINUS
  | TIMES
  | DIV
  | EOL
  | LPAREN
  | RPAREN

open Parsing;;
let yytransl_const = [|
  258 (* PLUS *);
  259 (* MINUS *);
  260 (* TIMES *);
  261 (* DIV *);
  262 (* EOL *);
  263 (* LPAREN *);
  264 (* RPAREN *);
    0|]

let yytransl_block = [|
  257 (* INT *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\000\000"

let yylen = "\002\000\
\002\000\001\000\003\000\003\000\003\000\003\000\003\000\002\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\002\000\000\000\000\000\009\000\000\000\008\000\
\000\000\000\000\000\000\000\000\000\000\001\000\003\000\000\000\
\000\000\006\000\007\000"

let yydgoto = "\002\000\
\006\000\007\000"

let yysindex = "\003\000\
\016\255\000\000\000\000\016\255\016\255\000\000\026\255\000\000\
\008\255\016\255\016\255\016\255\016\255\000\000\000\000\254\254\
\254\254\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\012\255\
\019\255\000\000\000\000"

let yygindex = "\000\000\
\000\000\252\255"

let yytablesize = 32
let yytable = "\008\000\
\009\000\012\000\013\000\001\000\000\000\016\000\017\000\018\000\
\019\000\010\000\011\000\012\000\013\000\004\000\004\000\015\000\
\003\000\004\000\004\000\004\000\005\000\005\000\005\000\000\000\
\005\000\000\000\005\000\010\000\011\000\012\000\013\000\014\000"

let yycheck = "\004\000\
\005\000\004\001\005\001\001\000\255\255\010\000\011\000\012\000\
\013\000\002\001\003\001\004\001\005\001\002\001\003\001\008\001\
\001\001\006\001\003\001\008\001\002\001\003\001\007\001\255\255\
\006\001\255\255\008\001\002\001\003\001\004\001\005\001\006\001"

let yynames_const = "\
  PLUS\000\
  MINUS\000\
  TIMES\000\
  DIV\000\
  EOL\000\
  LPAREN\000\
  RPAREN\000\
  "

let yynames_block = "\
  INT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun parser_env ->
    let _1 = (peek_val parser_env 1 : 'expr) in
    Obj.repr(
# 14 "dcparser.mly"
               ( _1 )
# 90 "dcparser.ml"
               : int))
; (fun parser_env ->
    let _1 = (peek_val parser_env 0 : int) in
    Obj.repr(
# 17 "dcparser.mly"
                                ( _1 )
# 97 "dcparser.ml"
               : 'expr))
; (fun parser_env ->
    let _2 = (peek_val parser_env 1 : 'expr) in
    Obj.repr(
# 18 "dcparser.mly"
                                ( _2 )
# 104 "dcparser.ml"
               : 'expr))
; (fun parser_env ->
    let _1 = (peek_val parser_env 2 : 'expr) in
    let _3 = (peek_val parser_env 0 : 'expr) in
    Obj.repr(
# 19 "dcparser.mly"
                                ( _1 + _3 )
# 112 "dcparser.ml"
               : 'expr))
; (fun parser_env ->
    let _1 = (peek_val parser_env 2 : 'expr) in
    let _3 = (peek_val parser_env 0 : 'expr) in
    Obj.repr(
# 20 "dcparser.mly"
                                ( _1 - _3 )
# 120 "dcparser.ml"
               : 'expr))
; (fun parser_env ->
    let _1 = (peek_val parser_env 2 : 'expr) in
    let _3 = (peek_val parser_env 0 : 'expr) in
    Obj.repr(
# 21 "dcparser.mly"
                                ( _1 * _3 )
# 128 "dcparser.ml"
               : 'expr))
; (fun parser_env ->
    let _1 = (peek_val parser_env 2 : 'expr) in
    let _3 = (peek_val parser_env 0 : 'expr) in
    Obj.repr(
# 22 "dcparser.mly"
                                ( _1 / _3 )
# 136 "dcparser.ml"
               : 'expr))
; (fun parser_env ->
    let _2 = (peek_val parser_env 0 : 'expr) in
    Obj.repr(
# 23 "dcparser.mly"
                                ( - _2 )
# 143 "dcparser.ml"
               : 'expr))
(* Entry main *)
; (fun parser_env -> raise (YYexit (peek_val parser_env 0)))
|]
let yytables =
  { actions=yyact;
    transl_const=yytransl_const;
    transl_block=yytransl_block;
    lhs=yylhs;
    len=yylen;
    defred=yydefred;
    dgoto=yydgoto;
    sindex=yysindex;
    rindex=yyrindex;
    gindex=yygindex;
    tablesize=yytablesize;
    table=yytable;
    check=yycheck;
    error_function=parse_error;
    names_const=yynames_const;
    names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (yyparse yytables 1 lexfun lexbuf : int)
