module Main where
import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT

screenTitle = "Arblegarg!"
screenWidth = 800
screenHeight = 600

z = 0.0::GLfloat

drawShape w = do
    color (Color3 (1.0::GLfloat) 0.0 0.0)
    vertex $ Vertex3 z z z
    vertex $ Vertex3 w z z
    vertex $ Vertex3 z w z
    vertex $ Vertex3 w w z

--    vertex $ Vertex3 w w w
--    vertex $ Vertex3 w w (-w)
--    vertex $ Vertex3 (-w) w (-w)
--    vertex $ Vertex3 (-w) w w

--    vertex $ Vertex3 w w w
--    vertex $ Vertex3 w (-w) w
--    vertex $ Vertex3 (-w) (-w) w
--    vertex $ Vertex3 (-w) w w

--    vertex $ Vertex3 (-w) w w
--    vertex $ Vertex3 (-w) w (-w)
--    vertex $ Vertex3 (-w) (-w) (-w)
--   vertex $ Vertex3 (-w) (-w) w

--    vertex $ Vertex3 w (-w) w
--    vertex $ Vertex3 w (-w) (-w)
--    vertex $ Vertex3 (-w) (-w) (-w)
--    vertex $ Vertex3 (-w) (-w) w

--    vertex $ Vertex3 w w (-w)
--    vertex $ Vertex3 w (-w) (-w)
--    vertex $ Vertex3 (-w) (-w) (-w)
--    vertex $ Vertex3 (-w) w (-w)


drawStuff = do
   loadIdentity
   let xaxis = (Vector3 1 0 0)
       yaxis = (Vector3 0 1 0)
       zaxis = (Vector3 0 0 1)

--   rotate (fromIntegral 10::GLfloat) xaxis
--   rotate (fromIntegral 10::GLfloat) yaxis
--   rotate (fromIntegral 10::GLfloat) zaxis 
   translate $ Vector3 (fromIntegral (-1)::GLfloat) (fromIntegral 0::GLfloat) (fromIntegral (-6)::GLfloat)
   --drawShape (0.5::GLfloat)
   color (Color3 (1.0::GLfloat) 0.0 0.0)

   -- GLUT is funny.
   renderObject Wireframe (Teapot 5.0)




idle = do
   swapBuffers
   idle

main = do
  putStrLn "Hello world!"
  initialize "Prog name" []
  initialDisplayMode $= [DoubleBuffered]
  initialWindowPosition $= Position 100 100
  initialWindowSize $= Size screenWidth screenHeight
  createWindow screenTitle
  --drawStuff
  idle
