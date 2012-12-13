(* hello-labltk.ml
   Hello world in labltk.

   Compile with:
   ocamlopt -I +labltk labltk.cmxa hello-labltk.ml

   Simon Heath
   22/4/2005
*)

let _ =
   let callback () = Tk.closeTk () in
   let toplevel = Tk.openTk () in
   let b = Button.create ~text: "Hello world!" ~command: callback toplevel in
      Tk.pack [b];
      Tk.mainLoop ()
;;
