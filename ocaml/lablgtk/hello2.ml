
let clicked msg () =
  print_endline msg;
  flush stdout
;;

let delete_event ev =
  print_endline "Bye!";
  GMain.Main.quit ();
  false
;;

let main () =
  let window = GWindow.window ~title: "Hello buttons!" ~border_width: 10 () in
    
    (* Set a handler for delete_event that exits GTK *)
    window#event#connect#delete ~callback: delete_event;
    (* Box to pack widgets into and put it in the window *)
    let box1 = GPack.hbox ~packing: window#add () in
    let button = GButton.button ~label: "Button 1" ~packing: box1#pack () in
    let button2 = GButton.button ~label: "Button 2" ~packing: box1#pack () in
      button#connect#clicked ~callback: (clicked "Button 1");
      button2#connect#clicked ~callback: (clicked "Button 2");
      
      window#show ();
      GMain.Main.main ()
;;

let _ = main ();;
