open Sdlvideo;;
open Sdlkey;;

let loadTexture filename =
   Printf.printf "Loading texture %s...  " filename;
   let surf = Sdlloader.load_image filename in
   let size = surface_info surf in
   let raw = Sdlgl.to_raw surf in

   let texid = GlTex.gen_texture () in
   let pix = GlPix.of_raw raw ~format: `rgb ~height: size.h ~width:
      size.w in

   GlTex.bind_texture `texture_2d texid;
   GlTex.image2d pix;
   Printf.printf "done.\n";
   texid

;;

let drawSkybox skyboximg =
   (*  GlTex.image2d skyboximg; *)
   Gl.enable `texture_2d;
   GlTex.bind_texture `texture_2d skyboximg;
   GlMat.push ();

   GlMat.translate ~x: 0. ~y: 0. ~z: 0. ();
   GlMat.scale ~x: 10. ~y: 10. ~z: 10. ();


   let r = 1.0
   and cx = 0.0
   and cz = 1.0 in

   (* XXX: Oops, quads suck.  Make it tri's *)
   (* Common axis z --front *)
   GlDraw.begins `quads;
   GlTex.coord2 (cx, cz);
   GlDraw.vertex3 (-.r, 1.0, -.r);
   GlTex.coord2 (cx, cx);
   GlDraw.vertex3 (-.r, 1.0,   r);
   GlTex.coord2 (cz, cx);
   GlDraw.vertex3 (r,   1.0,   r);

   GlTex.coord2 (cz, cx);
   GlDraw.vertex3 (r,   1.0,
   r);
   GlTex.coord2 (cz, cz);
   GlDraw.vertex3 (r,
   1.0, -.r);
   GlDraw.ends ();

   (*
   Back
   *)
   GlDraw.begins `quads;
   GlTex.coord2 (cx, cz);
   GlDraw.vertex3 (-.r, -1.0, -.r);
   GlTex.coord2 (cx, cx);
   GlDraw.vertex3 (-.r, -1.0, r);
   GlTex.coord2 (cz, cx);
   GlDraw.vertex3 (r, -1.0, r);
   GlTex.coord2 (cz, cz);
   GlDraw.vertex3 (r, -1.0, -.r);
   GlDraw.ends ();

   (* Common
    * axis
    * x
    * --left
    * *)
   GlDraw.begins `quads;
   GlTex.coord2 (cx, cz);
   GlDraw.vertex3 (-1.0, -.r, -.r);
   GlTex.coord2 (cx, cx);
   GlDraw.vertex3 (-1.0, -.r, r);
   GlTex.coord2 (cz, cx);
   GlDraw.vertex3 (-1.0, r, r);
   GlTex.coord2 (cz, cz);
   GlDraw.vertex3 (-1.0, r, -.r);
   GlDraw.ends ();

   (* Right
    * *)
   GlDraw.begins `quads;
   GlTex.coord2 (cx, cz);
   GlDraw.vertex3 (1.0, -.r, -.r);
   GlTex.coord2 (cx, cx);
   GlDraw.vertex3 (1.0, -.r, r);
   GlTex.coord2 (cz, cx);
   GlDraw.vertex3 (1.0, r, r);
   GlTex.coord2 (cz, cz);
   GlDraw.vertex3 (1.0, r, -.r);
   GlDraw.ends ();

   (* Common
    * axis
    * y
    * --top*)
   GlDraw.begins `quads;
   GlTex.coord2 (cx, cz);
   GlDraw.vertex3 (-.r, -.r, 1.0);
   GlTex.coord2 (cx, cx);
   GlDraw.vertex3 (-.r, r, 1.0);
   GlTex.coord2 (cz, cx);
   GlDraw.vertex3 (r, r, 1.0);
   GlTex.coord2 (cz, cz);
   GlDraw.vertex3 (r, -.r, 1.0);
   GlDraw.ends ();

   (* Bottom
    * *)
   GlDraw.begins `quads;
   GlTex.coord2 (cx, cz);
   GlDraw.vertex3 (-.r, -.r, -1.0);
   GlTex.coord2 (cx, cx);
   GlDraw.vertex3 (-.r, r, -1.0);
   GlTex.coord2 (cz, cx);
   GlDraw.vertex3 (r, r, -1.0);
   GlTex.coord2 (cz, cz);
   GlDraw.vertex3 (r, -.r, -1.0);
   GlDraw.ends ();

   GlMat.pop ();
   Gl.disable `texture_2d;
;;



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

let draw_gl_scene skybox =
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

   drawSkybox skybox;
   Sdlgl.swap_buffers ();
;;


let mainloop scr =
   let continue = ref true in
   let skybox = loadTexture "skybox.png" in

   while !continue do

      ignore (Sdlevent.poll());
      if (is_key_pressed KEY_q) then
         continue := false;

         draw_gl_scene skybox;

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


