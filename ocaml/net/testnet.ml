(* Just telnet to localhost:12345 *)
open Unix;;

let iaddr = inet_addr_of_string "127.0.0.1";;
let portnum = 12345;;


let _ = 
  let s1 = socket PF_INET SOCK_STREAM 0 in
  bind s1 (ADDR_INET( iaddr, portnum ));
  listen s1 1;
  let descr, addr = Unix.accept s1 in
  let inchan = in_channel_of_descr descr
  and outchan = out_channel_of_descr descr in
  let input = input_line inchan in
  let output = Printf.sprintf " Recieved: %s!\n" input in
  output_string outchan output;
  close s1;
;;
