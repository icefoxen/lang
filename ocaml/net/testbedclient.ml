(* testbedclient.ml
   It's sole purpose is to send information of a certain format every
   couple seconds.

   And apparently we still have some bugs to work out concerning the 
   shutting-down and reuse of sockets and connections...

   To compile: ocamlc -thread unix.cma threads.cma testbedclient.ml

   Simon Heath
   21/6/2005
*)

open Unix;;


let foo () =
  if Array.length Sys.argv < 2 then (
    Printf.eprintf "Usage: %s portnum\n" Sys.argv.(0);
    exit 1;
  );
  let pn = int_of_string Sys.argv.(1) in
  let sock = socket PF_INET SOCK_STREAM 0 in
  let localhost = inet_addr_of_string "192.168.5.26" in
    Unix.connect sock (ADDR_INET( localhost, pn ));
    let ic = in_channel_of_descr sock
    and oc = out_channel_of_descr sock in
      while true do


	let t = Unix.time () in
	  output_byte oc ((int_of_float t) mod 255);
	  output_binary_int oc (int_of_float t);
	  output_string oc ((string_of_float t) ^ "\n");
	  output_value oc t;
	  Printf.printf "Stuff sent: %f\n" t;
	  Pervasives.flush Pervasives.stdout;
	  (* The flush here is important!! *)
	  Pervasives.flush oc;
	  (* shutdown sock SHUTDOWN_ALL; *)
	  
	  sleep 6;
      done;
;;

let _ =
  handle_unix_error foo ()
;;
