(* testserver.ml
   A slightly more complete server program.

   Simon Heath
   21/6/2005
*)

open Unix;;

let establish_server server_fun sockaddr =
   let sock = socket PF_INET SOCK_STREAM 0 in
   bind sock sockaddr;
   listen sock 3;
   while true do
      let (s, caller) = accept sock in
      match fork () with
         0 -> if fork () <> 0 then exit 0;
	      let inchan = in_channel_of_descr s
	      and outchan = out_channel_of_descr s in
	      server_fun inchan outchan;
	      close_in inchan;
	      close_out outchan;
	      exit 0
       | id -> close s; ignore (waitpid [] id)
   done
;;

let main_server serv_fun =
   if Array.length Sys.argv < 2 then Printf.eprintf "usage: testserver port\n"
   else try
      let port = int_of_string Sys.argv.(1) in
      let my_address = inet_addr_of_string "127.0.0.1" in
      establish_server serv_fun (ADDR_INET( my_address, port ))
   with
      Failure( "int_of_string" ) -> Printf.eprintf "testserver: bad port num!\n"

;;

let uppercase_service ic oc =
   try while true do
      let s = input_line ic in
      let r = String.uppercase s in
      output_string oc (r ^ "\n");
      flush oc;
   done
   with _ -> (Printf.printf "EOF\n"; exit 0;)
;;

let _ =
   handle_unix_error main_server uppercase_service
;;
