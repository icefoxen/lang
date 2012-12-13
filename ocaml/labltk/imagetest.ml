(* hello-labltk.ml
   Hello world in labltk.

   Simon Heath
   22/4/2005
*)

let _ =
   let callback () = Tk.closeTk () in
   let toplevel = Tk.openTk () in
   let b = Button.create ~text: "Exit" ~command: callback toplevel
   and i = Imagebitmap.create ~file: "foo.bmp" ()
   and l = (* Ummmmm...  how do we show a bitmap?? *)
      Tk.pack [b];
      Tk.mainLoop ()
;;
