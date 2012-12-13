(* hello.ml
   Hello world in Lablgtk.

   Compile with:
   ocamlopt -I +lablgtk lablgtk.cmxa gtkInit.cmx hello.ml

   Simon Heath
   22/4/2005
*)

let _ =
   let window = GWindow.window ~border_width: 10 () in
   let button = GButton.button ~label: "Hello world!" ~packing: window#add ()
   in
   window#event#connect#delete
     (* if we return true, the window sticks around on a window-manager close
	event *)
      ~callback: (fun _ -> print_endline "Delete occured!"; false);
   window#connect#destroy ~callback: Main.quit;
   button#connect#clicked ~callback: (fun () -> print_endline "Hello there!");
   button#connect#clicked ~callback: window#destroy;
   window#show ();
   GMain.Main.main ();
;;
