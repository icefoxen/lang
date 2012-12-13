(* quotechooser.ml
   Chooses a random quote from my quote list.
   OCaml's regexps actually WORK for this.
   Unlike Python's.
   Yeesh.

   30/09/2004
*)


let quotefile = open_in "/win/writings/quotes.txt" 
and re = Str.regexp "^-[a-zA-Z0-9\\?].*\n" in

(* No generic slurp-function provided; we write one.  Silly. 
   ...VERY silly.  input only reads one page at a time; 4096 bytes.
   Silly and C-ish.  
*)
let slurpFile f =
   let filelen = in_channel_length f in
   let s = String.create filelen in
   let _ = input f (String.create filelen) 0 filelen in
   s
   in

(* Um... so we split everything into a list, we grab a random item, 
   we grab the person who did it, we print them out. *)

let lst = Str.full_split re (slurpFile quotefile) in
let _ = Random.self_init () in
let rnum = Random.int (List.length lst) in
(* Always choose an even number *)
let rnum = if rnum / 2 = 1 then rnum + 1 else rnum in
let rec ncdr lst n = 
   if n = 0 then lst 
   else ncdr (List.tl lst) (n - 1) in

print_int (List.length lst);
print_newline ();
print_int rnum;
let tl = ncdr lst rnum in
let quote = List.hd tl
and attrib = List.hd (List.tl tl) in
match quote with
   Str.Text( s ) -> print_endline s
 | Str.Delim( _ ) -> print_endline "That's not right!";

match attrib with
   Str.Text( _ ) -> print_endline "That's not right!"
 | Str.Delim( s ) -> print_endline s;
