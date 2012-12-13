let rec listReverse list =
   if list = [] then []
   else
      let hd = List.hd list
      and tl = List.tl list in
      (listReverse tl) @ [hd]
;;



let rec listReverse2 list accm =
   if list = [] then accm
   else
      let hd = List.hd list
      and tl = List.tl list in
         listReverse2 tl (hd :: accm)
;;

