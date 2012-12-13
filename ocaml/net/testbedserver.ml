(* testbedserver.ml
   This is a server that tests out the general architecture that we're 
   going to use for melee/Voidrunner
   In other words, there's a main loop that prints out info and there's
   a network thread that just listens for packets and sticks the contents
   on a queue.
   We also experiment with marshalling things over the network.  It seems
   to work pretty damn well, as long as nothing foreign gets mixed in.
   
   Compile with: ocamlc -thread unix.cma threads.cma testbedserver.ml

   This seems to work, but needs a seperate thread/whatever for each
   connection sending data in.
   The thread dies with an EOF when the connection closes, y'see...
   However, it's not as though we have an unbounded number of clients...

   I KNOW there's some way to have multiple clients connect to the same
   socket.  How though?  Multiple accepts?  Nah, we can do multiple 
   listen/accepts, but it just takes the connections sequentially.
   I mean, there's the obvious solution of accepting a connection, handing
   back a new port number, and letting it go at that, but...
   select() would work nicely there.
   OOO!  Here's how it works!  socket and accept give you two DIFFERENT fd's!
   So you listen for a connection, when you get it you accept it, and do
   all your communication through the fd you get from that.  Meanwhile,
   listen's fd is still out there, listening away, and if you get another
   connection you can accept it again and get a completely different fd!!!

   Non-blocking sockets would be nice too...  If I could do that, I could
   ditch the thread entirely, pretty much.


   Simon Heath
   21/6/2005
*)


open Unix;;
open Thread;;


let eventQ = Queue.create ();;
let qMutex = Mutex.create ();;

let netThread port =
  let localhost = inet_addr_of_string "127.0.0.1" in
  let sock = socket PF_INET SOCK_STREAM 0 in
    bind sock (ADDR_INET( localhost, port ));

    while true do
      try
	listen sock 16;
	let (fd, caller) = accept sock in
	let ic = in_channel_of_descr fd
	and oc = out_channel_of_descr fd in
	  while true do
	    let datab = input_byte ic in
	    let datai = input_binary_int ic in
	    let datas = input_line ic in
	    let dataf = (input_value ic : float) in
	      print_endline "Stuff read";
	      (match caller with
		   ADDR_UNIX( s ) -> 
		     Printf.eprintf "Should never happen!\n"; 
		 | ADDR_INET( iaddr, iport ) ->
		     Printf.printf "Recieved data from %s:%d\n" 
		       (string_of_inet_addr iaddr) iport;
		     Mutex.lock qMutex;
		     Queue.add (datab, datai, dataf, datas) eventQ;
		     Mutex.unlock qMutex;
	      );
	  done;
      with
	  End_of_file -> print_endline "Connection closed, setting up again";
    done;
;;


let printRecievedData d =
  let datab, datai, dataf, datas = d in
    Printf.printf "Recieved: b%d, i%d, f%f, s%s\n"
      datab datai dataf datas;
;;


let foo () =
  if (Array.length Sys.argv) < 2 then (
    Printf.eprintf "Usage: %s portnum\n" Sys.argv.(0);
    exit ();
  );
  let pn = int_of_string Sys.argv.(1) in
  let nt = Thread.create netThread pn in

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
