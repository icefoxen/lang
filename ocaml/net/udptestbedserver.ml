(* testbedserver.ml
   This is a server that tests out the general architecture that we're 
   going to use for melee/Voidrunner
   In other words, there's a main loop that prints out info and there's
   a network thread that just listens for packets and sticks the contents
   on a queue.
   We also experiment with marshalling things over the network.
   
   Compile with: ocamlc -thread unix.cma threads.cma testbedserver.ml

   This can recieve from just about anything at any time.  Handy.  However,
   it's unreliable.  It can also NOT recieve from just about anything at
   any time.
   However, we don't seem able to get the information of what IP and port
   a packet came from, at least not through the standard API.  Annoying.

   Simon Heath
   21/6/2005
*)


open Unix;;
open Thread;;


let eventQ = Queue.create ();;
let qMutex = Mutex.create ();;

let netThread port =
  let localhost = inet_addr_of_string "192.168.5.26" in
  let sock = socket PF_INET SOCK_DGRAM 0 in
    bind sock (ADDR_INET( localhost, port ));
      let ic = in_channel_of_descr sock
      and oc = out_channel_of_descr sock in 
	while true do
	  let datai = input_binary_int ic in
		   Mutex.lock qMutex;
		   Queue.add datai eventQ;
		   Mutex.unlock qMutex;
	done;
;;


let printRecievedData d =
    Printf.printf "Recieved: i%dn" d;
;;


let foo () =
  if (Array.length Sys.argv) < 2 then (
    Printf.eprintf "Usage: %s portnum\n" Sys.argv.(0);
    exit ();
  );
  let pn = int_of_string Sys.argv.(1) in
  let nt = Thread.create (handle_unix_error netThread) pn in

    while true do
      Mutex.lock qMutex;
      while not (Queue.is_empty eventQ) do
	printRecievedData (Queue.take eventQ);
      done;
      Mutex.unlock qMutex;
      Printf.printf "Stuff done!\n";
      Pervasives.flush Pervasives.stdout;
      sleep 5;
    done
;;


let _ =
  handle_unix_error foo ()
;;
