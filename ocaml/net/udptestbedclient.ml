(* testbedclient.ml
   It's sole purpose is to send information of a certain format every
   couple seconds.

   To compile: ocamlc -thread unix.cma threads.cma testbedclient.ml

   This is handily almost-identical to the TCP version.

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
  let sock = socket PF_INET SOCK_DGRAM 0 in
  let localhost = inet_addr_of_string "192.168.5.26" in
    Unix.connect sock (ADDR_INET( localhost, pn ));
    let ic = in_channel_of_descr sock
    and oc = out_channel_of_descr sock in
    let t = Unix.time () in
      for x = 0 to 1024 do
	  output_binary_int oc 1;
	  (* The flush here is important!! *)
      done;
      Pervasives.flush oc;
    let t2 = Unix.time () in
    Printf.printf "Sent 4 megs of stuff in %f seconds\n" (t2 -. t);
;;

let _ =
  handle_unix_error foo ()
;;
