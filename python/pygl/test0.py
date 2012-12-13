# Okay.
# THANK you.
# Now, let's get to hacking Python OpenGL.
# Foist, we want to create a shape and move it with da arrow keys.

from OpenGL.GL import *
from OpenGL.GLU import *
import pygame
from pygame.locals import *

translatex = -1.5
translatey = 0.0
translatez = -6.0

def setSizeGL( (width, height) ):
    if height == 0:
        height = 1

    glViewport( 0, 0, width, height )
    glMatrixMode( GL_PROJECTION )
    glLoadIdentity()
    
    gluPerspective( 45, 1.0 * width / height, 0.1, 100.0 )
    glMatrixMode( GL_MODELVIEW )
    glLoadIdentity()

def initGL():
    glShadeModel( GL_SMOOTH )
    glClearColor( 0.0, 0.0, 0.0, 0.0 )
    glClearDepth( 1.0 )
    glEnable( GL_DEPTH_TEST )
    glDepthFunc( GL_LEQUAL )
    glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST )

def drawGL():
    global translatex
    global translatey
    global translatez
    
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT )
    glLoadIdentity()

    #glTranslatef( -1.5, 0.0, -6.0 )
    #print translatex, translatey, translatez
    glTranslatef( translatex, translatey, translatez )
    
    glBegin( GL_TRIANGLES )
    glVertex3f( 0.0, 1.0, 0.0 )
    glVertex3f( -1.0, -1.0, 0.0 )
    glVertex3f( 1.0, -1.0, 0.0 )
    glEnd()

    glTranslatef( 3.0, 0.0, 0.0 )
    glBegin( GL_QUADS )
    glVertex3f( -1.0, 1.0, 0.0 )
    glVertex3f( 1.0, 1.0, 0.0 )
    glVertex3f( 1.0, -1.0, 0.0 )
    glVertex3f( -1.0, -1.0, 0.0 )
    glEnd()
    


def main():
    global translatex
    global translatey
    global translatez
    videoFlags = OPENGL | DOUBLEBUF
    screenSize = (640,480)

    pygame.init()
    pygame.display.set_mode( screenSize, videoFlags )

    setSizeGL( screenSize )
    initGL()

    frames = 0
    ticks = pygame.time.get_ticks()
    while True:
        event = pygame.event.poll()
        if event.type == QUIT:
            break
        if event.type == KEYDOWN:
            if event.key == K_RIGHT:
                translatex += 0.25
            elif event.key == K_LEFT:
                translatex -= 0.25
            elif event.key == K_UP:
                translatey += 0.25
            elif event.key == K_DOWN:
                translatey -= 0.25
            elif event.key == K_a:
                translatez += 0.25
            elif event.key == K_z:
                translatez -= 0.25


        drawGL()
        pygame.display.flip()
        frames += 1

    print "FPS: %d" % ((frames * 1000) / (pygame.time.get_ticks() - ticks))



if __name__ == '__main__':
    main()
