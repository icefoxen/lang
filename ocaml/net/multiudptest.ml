(* multiudptest.ml
   Test on sending packets to multiple UDP listeners.
*)

open Unix;;


let sendPacket sock oc iaddr =
   connect sock iaddr;
   output_binary_int oc 10;
   flush oc;
;;


let _ = 
   let clientlst = ref [] in
   for x = 1 to (Array.length Sys.argv - 1) do
      clientlst := ADDR_INET( (inet_addr_of_string Sys.argv.(x)), (8000+x) )
      :: !clientlst;
   done;

   let sock = socket PF_INET SOCK_DGRAM 0 in
   let oc = out_channel_of_descr sock in
   for x = 0 to 10 do
   List.iter (sendPacket sock oc) !clientlst;
   print_endline "Stuff sent!";
   flush Pervasives.stdout;
   done;
()
   ;;
