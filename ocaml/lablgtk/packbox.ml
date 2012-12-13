(* packbox.ml
   Playing with packing and boxes and shibby junk like that!

   Simon Heath
   26/5/2005
*)


let make_box ~homogeneous ~spacing ~expand ~fill ~padding ?packing () =
  (* Create new box *)
  let box = GPack.box `HORIZONTAL ~homogeneous: homogeneous ~spacing: spacing
(*	      ~packing: packing *) () in
    (* Create buttons *)
    for x = 0 to 4 do
      let button = GButton.button ~label: "Stuff" 
		     ~packing: (box#pack ~expand ~fill ~padding) () in
	()
    done;
    
    (* Create buttons with various labels depending on params *)
    let button = GButton.button ~label: (if expand then "EXPAND" 
					 else "NO EXPAND")
		   ~packing: box#pack in
    let button = GButton.button ~label: (if fill then "FILL" 
					 else "NO FILL")
		   ~packing: box#pack in
    let button = GButton.button ~label: (Printf.sprintf "%d" padding)
		   ~packing: box#pack in

      box
;;

let main () =
  if Array.length Sys.argv < 2 then (
    prerr_endline "Usage: packbox num, where num is 1, 2, or 3";
    exit 1;
  );
  let which = int_of_string Sys.argv.(1) in
  let window = GWindow.window ~title: "Packing" ~border_width: 10 () in
    window#connect#destroy ~callback: GMain.Main.quit;
    let box1 = GPack.vbox ~packing: window#add () in
      
      begin match which with
	  1 ->
	    let label = GMisc.label ~text: "hbox_new (false, 0)" () in
	      label#set_xalign 0.0;
	      label#set_yalign 0.0;
	      box1#pack ~expand: false ~fill: false ~padding: 0 label#coerce;

	      let box2 = make_box ~homogeneous: false ~spacing: 0
			   ~expand: false ~fill: false ~padding: 0 () in
		box1#pack ~expand: false ~fill: false ~padding: 0 box2#coerce;
		let box2 = make_box ~homogeneous: false ~spacing: 0
			     ~expand: false ~fill: false ~padding: 0 () in
		  box1#pack ~expand: false ~fill: false 
		    ~padding: 0 box2#coerce;
		  let sep = GMisc.separator `HORIZONTAL () in
		    box1#pack ~expand: false ~fill: false 
		      ~padding: 5 sep#coerce;

		    let label = GMisc.label ~text:"hbox_new (true, 0);" () in
		      label#set_xalign 0.0;
		      label#set_yalign 0.0;
		      box1#pack ~expand:false ~fill:false ~padding:0 
			label#coerce;

		      let box2 = make_box ~homogeneous:true ~spacing:0
				   ~expand:true ~fill:false ~padding:0 () in
			box1#pack ~expand:false ~fill:false ~padding:0 
			  box2#coerce;

			let box2 = make_box ~homogeneous:true ~spacing:0
				     ~expand:true ~fill:true ~padding:0 () in
			  box1#pack ~expand:false ~fill:false ~padding:0 
			    box2#coerce;

			  (* Another new separator. *)
			  let separator = GMisc.separator `HORIZONTAL () in
			    box1#pack ~expand:false ~fill:true ~padding:5 
			      separator#coerce;
	| _ -> ()
      end;
      let quitbox = GPack.hbox ~homogeneous:false ~spacing:0
		      ~packing:(box1#pack ~expand:false 
				  ~fill:false ~padding:0) () in

      (* Our quit button. *)
      let button = GButton.button ~label:"Quit"
		     ~packing:(box1#pack ~expand:false 
				 ~fill:false ~padding:0) () in
	button#connect#clicked ~callback:GMain.Main.quit;

	(* Showing the window last so everything pops up at once. *)
	window#show ();

	(* And of course, our main function. *)
	GMain.Main.main ()
;;
let _ = Printexc.print main ()
		
		  
