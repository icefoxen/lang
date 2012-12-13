open Sdlvideo;;
open Sdlkey;;

let init_gl width height =
  GlDraw.shade_model `smooth;
  GlClear.color (0.0, 0.0, 0.0);
  GlClear.depth 1.0;
  GlClear.clear [`color; `depth];
  Gl.enable `depth_test;
  GlFunc.depth_func `lequal;
  GlMisc.hint `perspective_correction `nicest;

  GlDraw.viewport 0 0 width height;
  GlMat.mode `projection;
  GlMat.load_identity ();
  GluMat.perspective ~aspect: (float_of_int (width / height)) ~z: (0.1, 100.0) ~fovy: 45.0;
  GlMat.mode `modelview;
  GlMat.load_identity()
;;

let draw_gl_scene () =
  GlClear.clear [`color; `depth];
  GlMat.load_identity ();
  (* Draw the triangle *)
  GlMat.translate3 (-1.5, 0.0, -9.0);
  GlDraw.color (1.0, 1.0, 1.0);
  GlDraw.begins `triangles;
  GlDraw.vertex3 ( 0.0,  1.0, 0.0);
  GlDraw.vertex3 (-1.0, -1.0, 0.0);
  GlDraw.vertex3 ( 1.0, -1.0, 0.0);
  GlDraw.ends ();
  (* Draw the square *)
  GlMat.translate3 (3.0, 0.0, 0.0);
  GlDraw.begins `quads;
  GlDraw.vertex3 (-1.0,  1.0, 0.0);
  GlDraw.vertex3 ( 1.0,  1.0, 0.0);
  GlDraw.vertex3 ( 1.0, -1.0, 0.0);
  GlDraw.vertex3 (-1.0, -1.0, 0.0);
  GlDraw.ends ();
  Sdlgl.swap_buffers ();
;;


let mainloop scr =
  let continue = ref true in

    while !continue do

      ignore (Sdlevent.poll());
      if (is_key_pressed KEY_q) then
	continue := false;

      draw_gl_scene ();

      (* Epilogue *)
      flush stdout;
      flip scr;

    done
;;

let main () =
  Sdl.init [`EVERYTHING];
  Sdlwm.set_caption ~title: "SDL GL Test" ~icon: "EoF";
  (*Sdlmouse.show_cursor false;*)

  Sdlttf.init ();
  Random.self_init ();

  (* Grafix setup *)
  let screen = set_video_mode ~w: 640 ~h:  480 ~bpp: 32 
    [`OPENGLBLIT;`DOUBLEBUF] in

    init_gl 640 480;

    (* Mainloop *)
    mainloop screen;


    (* De-init *)
    Sdlttf.quit ();
    Sdl.quit ()    
;;


let _ =
  main ()
;;


