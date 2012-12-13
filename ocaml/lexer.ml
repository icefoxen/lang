
let currentexp = ref [];;

let isWhitespace = function
   ' '  -> true
 | '\t' -> true
 | '\n' -> true
 | '\r' -> true
 | _    -> false;;

let pushToken str =
   currentexp := str :: !currentexp;;

let tokenize str =
   let x = ref 0 in
   let token = ref "" in
   while !x < String.length str do
      let chr = String.get str !x in
      if isWhitespace chr then
         if !token <> "" then
            let () = pushToken !token in
            token := "" 
         else ()
      else  (* Probably not very efficient... *)
         token := (String.concat "" 
                                 [!token; (String.make 1 chr)]);
         
      x := !x + 1;
   done;;

let dunreading = false;;

let prompt =  "-> ";;
let prompt2 = ">  ";;

let count_parens str =
   let count = ref 0 in
   for i = 0 to (String.length str) - 1 do
      match String.get str i with
         '(' -> count := !count + 1
       | ')' -> count := !count - 1
       | _   -> ()
   done;
   !count;;

let string_of_char c =
   String.make 1 c;;

let readparens () =
   print_string prompt;
   let str = ref (read_line ()) in
   while count_parens !str > 0 do
      print_string prompt2;
      str := !str ^ "\n" ^ read_line ();
   done;
   !str ^ "\n";;  (* Must append newline so we know when comments end *)

let decomment str =
   let incomment = ref false in
   let ret = ref "" in
   for i = 0 to (String.length str) - 1 do
      if String.get str i = ';' then
         incomment := true
      else
      if !incomment && String.get str i = '\n' then
         incomment := false
      else ();
      if not !incomment then
         ret := !ret ^ string_of_char (String.get str i)
      else ();
   done;
   !ret;;

let deWhitespace str =
   let ret = ref "" in
   for i = 0 to (String.length str) - 1 do
      if isWhitespace (String.get str i) then
         ret := !ret ^ " "
      else
         ret := !ret ^ string_of_char (String.get str i);
   done;
   !ret;;

let read () =
   let input = ref "" in
   while not dunreading do
      print_string (deWhitespace (decomment (readparens ())));
   done;
   ();;
