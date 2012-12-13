(* table.ml
   Tables!

   Simon Heath
   26/5/2005
*)


let hello msg () =
  Printf.printf "Hello! %s was pressed\n" msg;
  flush stdout
;;

let main () =
  let window = GWindow.window ~title: "Table" ~border_width: 5 () in
    window#connect#destroy ~callback: GMain.Main.quit;

    let table = GPack.table ~rows: 2 ~columns: 2 ~homogeneous: true
		  ~packing: window#add () in
    let b1 = GButton.button ~label: "Button 1" ()
    and b2 = GButton.button ~label: "Button 2" ()
    and qb = GButton.button ~label: "Quit" () in
      table#attach ~left: 0 ~top: 0 b1#coerce;
      table#attach ~left: 1 ~top: 0 b2#coerce;
      table#attach ~left: 0 ~right: 2 ~top: 1 qb#coerce;

      b1#connect#clicked ~callback: (hello "Button 1");
      b2#connect#clicked ~callback: (hello "Button 2");
      qb#connect#clicked ~callback: GMain.Main.quit;

      window#show ();
      GMain.Main.main ();

;;


let _ = 
  Printexc.print main ()
;;
      
      
