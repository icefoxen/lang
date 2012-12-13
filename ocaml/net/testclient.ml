(* Simple test client *)

open Unix;;

let open_connection sockaddr =
   let sock = socket PF_INET SOCK_STREAM 0 in
   try
      Unix.connect sock sockaddr;
      (Unix.in_channel_of_descr sock, Unix.out_channel_of_descr sock)
   with
      ex -> Unix.close sock; raise ex
;;

let shutdown_connection inchan =
  shutdown (descr_of_in_channel inchan) SHUTDOWN_SEND
;;

let main_client 
