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

tRot = cRot = 0.0

def setSizeGL( (width, height) ):
    if height == 0:
        height = 1

    glViewport( 0, 0, width, height )

    # Do stuff to projection matrix
    glMatrixMode( GL_PROJECTION )
    glLoadIdentity()
    # 0.1 and 100.0 are the min and max depth distance
    gluPerspective( 45, 1.0 * width / height, 0.1, 100.0 )

    # Do stuff to model view matrix
    glMatrixMode( GL_MODELVIEW )
    glLoadIdentity()

def initGL():
    glShadeModel( GL_SMOOTH )
    glClearColor( 0.0, 0.0, 0.0, 0.0 )
    glClearDepth( 1.0 )
    glEnable( GL_DEPTH_TEST )
    glDepthFunc( GL_LEQUAL )
    glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST )


r = 0.0
g = 1.0
b = 0.5

def drawGL():
    global translatex
    global translatey
    global translatez
    
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT )
    glLoadIdentity()

    #glTranslatef( -1.5, 0.0, -6.0 )
    #print translatex, translatey, translatez
    glTranslatef( translatex, translatey, translatez )

    global r
    global g
    global b

    global tRot
    glRotate( tRot, 1.0, 1.0, 0.0 )
    glBegin( GL_TRIANGLES )
    
    glColor3f( r, g, b )
    glVertex3f( 0.0, 1.0, 0.0 )
    glColor3f( 0.0, 1.0, 0.0 )
    glColor3f( g, b, r )
    glVertex3f( -1.0, -1.0, 1.0 )
    glColor3f( 0.0, 0.0, 1.0 )
    glColor3f( b, r, g )
    glVertex3f( 1.0, -1.0, 1.0 )

    glColor3f( 1.0, 0.0, 0.0 )
    glColor3f( r, g, b )
    glVertex3f( 0.0, 1.0, 0.0 )
    glColor3f( 0.0, 1.0, 0.0 )
    glColor3f( g, b, r )
    glVertex3f( 1.0, -1.0, 1.0 )
    glColor3f( 0.0, 0.0, 1.0 )
    glColor3f( b, r, g )
    glVertex3f( 1.0, -1.0, -1.0 )

    glColor3f( 1.0, 0.0, 0.0 )
    glColor3f( b, r, g )
    glVertex3f( 0.0, 1.0, 0.0 )
    glColor3f( 0.0, 1.0, 0.0 )
    glColor3f( r, b, g )
    glVertex3f( 1.0, -1.0, -1.0 )
    glColor3f( 0.0, 0.0, 1.0 )
    glColor3f( b, r, g )
    glVertex3f( -1.0, -1.0, -1.0 )

    glColor3f( 1.0, 0.0, 0.0 )
    glColor3f( r, b, g )
    glVertex3f( 0.0, 1.0, 0.0 )
    glColor3f( 0.0, 1.0, 0.0 )
    glColor3f( g, r, b )
    glVertex3f( -1.0, -1.0, -1.0 )
    glColor3f( 0.0, 0.0, 1.0 )
    glColor3f( b, g, r )
    glVertex3f( -1.0, -1.0, 1.0 )
    
    glEnd()

    glLoadIdentity()

    global cRot
    glTranslatef( 1.5, 0.0, -6.0 )
    glRotate( cRot, -1.0, 0.0, 0.0 )
    glBegin( GL_POLYGON )
    glColor3f( 1.0, 0.0, 0.0 )
    glVertex3f( -1.0, 1.0, 0.0 )

    glColor3f( 1.0, 1.0, 0.0 )
    glVertex3f( 0.0, 2.0, 0.0 )

    glColor3f( 0.0, 1.0, 0.0 )
    glVertex3f( 1.0, 1.0, 0.0 )

    glColor3f( 0.0, 1.0, 1.0 )
    glVertex3f( 1.0, -0.0, 0.0 )

    glColor3f( 0.0, 0.0, 1.0 )
    glVertex3f( 0.0, -1.0, 0.0 )

    glColor3f( 1.0, 0.0, 1.0 )
    glVertex3f( -1.0, -0.0, 0.0 )
    
    #glVertex3f( -1.0, -2.0, 0.0 )
    #glVertex3f( -1.5, -1.0, 0.0 )
    glEnd()

    tRot += 0.2
    cRot += 0.2

    r = (r +0.005) % 1
    g = (g +0.005) % 1
    b = (b +0.005) % 1
    


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
