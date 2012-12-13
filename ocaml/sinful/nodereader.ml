(* nodereader.ml
   This is a loader to read a .sin file and turn it into a node. 
   The syntax of a .sin file is thus:
---
   <nodename>

   <desc>

   <item1> <item2> ...

   <event1> <event2> ...
   
   <link1> <link2> ...
---

   It also loads .itm files, which are merely text files that represent item
   descriptions.
   
   Simon Heath
   4/7/2003
*)


(* This gets a directory listing and returns it, minus the . and .. dirs. *)
let listDir dir =
   let a = Unix.opendir dir
   and continue = ref true
   and str = ref []
   and dedot = (function "." -> false | ".." -> false | _ -> true)
   in
      while !continue do
         (* This reads the lines in reverse order; it's fine here, but you
            don't want to do this while reading a real file. *)
         try str := (Unix.readdir a) :: !str with
            End_of_file -> continue := false;
      done; 
      Unix.closedir a;
      List.filter dedot !str;;


let readField filedesc =
   let readdata = ref ""
   and finaldata = ref ""
   and continue = ref true
   in
      while !continue do
         (* We do this whole thing in the "try" body so it skips trying to
            append new data if we hit the end of the file  *)
         try begin
            (* Grab the line, and test to see if it's a blank line.
               input_line does NOT include the \n's it reads!  *)
            readdata := (input_line filedesc);
            if !readdata = ""
            (* If it is, we're done *)
            then continue := false
            (* Otherwise, stick it onto the finaldata string. *)
            else finaldata := !finaldata ^ !readdata
         end
         with End_of_file -> continue := false;
      done;
      !finaldata;;


(* This slurps up all the whitespace at the start of a string  *)
let rec killLeadingWhitespace str =
   if str <> ""
   then
      let firstchar = String.get str 0
      and rest = String.sub str 1 ((String.length str) - 1)
      in
         match firstchar with
            ' '  -> killLeadingWhitespace rest
          | '\t' -> killLeadingWhitespace rest
          |  _   -> str
   else
      ""
   ;;
   

(* A recursive worker function for splitAtSpace
   It takes a string and returns a list of strings, seperated at spaces.
   The order is reversed, but that shouldn't matter for this.  *)
let rec splitAtSpace' str retlst =
   let s = killLeadingWhitespace str
   in
   if String.contains s ' '
   then
      let ind = String.index s ' '
      in
         splitAtSpace'
            (String.sub s ind ((String.length s) - ind))
            ((String.sub s 0 ind) :: retlst)
   else
      s :: retlst;;

let splitAtSpace str =
   splitAtSpace' str [];;


(* This function takes a list of strings, and builds an item from each one,
   searching for a file called <string>.itm for the description  *)
let buildItem dir str =
   let desc = ref ""
   and continue = ref true
   and file = open_in (dir ^ "/" ^ str ^ ".itm")
   in
      while !continue do
      try desc := !desc ^ (input_line file) with
         End_of_file -> continue := false
      done;
      Items.makeItem str !desc;;

let buildItems strLst dir =
   List.map (buildItem dir) strLst;;


(* This reads a .sin file and does all the necessary parsing to turn it into a
   node.  Which it then returns.  *)
let readNode filename dir =
   let f = open_in (dir ^ "/" ^ filename)
   (* These assignments MUST be imperative, since order matters!  *)
   and name = ref ""
   and desc = ref ""
   and events = ref []
   and items = ref []
   and edges = ref []
   in
      (* You may consider the order of these to be magic, since it depends on
         the file format.  Maybe I should have made explicit marker-characters
         instead of just splitting at newlines.  Oh well.  *)
      name := readField f;
      desc := readField f;
      events := [];
      items := buildItems (splitAtSpace (readField f)) dir;
      edges := splitAtSpace (readField f);
      close_in f;
      Node.makeNode !name !desc !events !items !edges
      ;;


(* This filters a list of paths so that it only has .sin files  *)
let getSins pathlist =
   List.filter 
      (function x -> (String.sub x ((String.length x) - 4) 4) = ".sin")
      pathlist;;

let getItms pathlist =
   List.filter 
      (function x -> (String.sub x ((String.length x) - 4) 4) = ".itm")
      pathlist;;


let buildGraph dir =
   List.map ((function x -> function y -> (readNode y x)) dir) 
            (getSins (listDir dir))
   ;;
