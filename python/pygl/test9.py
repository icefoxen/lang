# Nehe tutorial 6-8!
# Note that blending is not real transparency;
# Light will not shine through surfaces!

from OpenGL.GL import *
from OpenGL.GLU import *
import pygame
from pygame.locals import *

import os
from math import *

translatex = -1.5
translatey = 0.0
translatez = -6.0

xrot = 0.0
yrot = 0.0
zrot = 0.0

xpos = 0.0
ypos = 0.0
zpos = 0.0

lookupdown = 0.0

xspeed = 0.0
yspeed = 0.0

filtr = 0
textures = []

tris = []

piover180 = pi / 180.0


lightAmbient  = ( (0.5, 0.5, 0.5, 1.0) )
lightDiffuse  = ( (1.0, 1.0, 1.0, 1.0) )
lightPosition = ( (0.0, 0.0, 2.0, 1.0) )


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


def loadTextures():
    global lightAmbient, lightDiffuse, lightPosition
    global textures
    textureFile = os.path.join( 'data', 'mud.bmp' )
    textureSurface = pygame.image.load( textureFile )
    textureData = pygame.image.tostring( textureSurface, 'RGBX', 1 )

    textures = glGenTextures( 3 )

    glBindTexture( GL_TEXTURE_2D, textures[0] )
    glTexImage2D( GL_TEXTURE_2D, 0, GL_RGBA, textureSurface.get_width(), \
                  textureSurface.get_height(), 0, GL_RGBA, \
                  GL_UNSIGNED_BYTE, textureData )
    # Nearest filtering is just literal translation
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST )
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST )

    # Linear filtering does pretty anti-aliasing
    glBindTexture( GL_TEXTURE_2D, textures[1] )
    glTexImage2D( GL_TEXTURE_2D, 0, GL_RGBA, textureSurface.get_width(), \
                  textureSurface.get_height(), 0, GL_RGBA, \
                  GL_UNSIGNED_BYTE, textureData )
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR )
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR )

    # Mipmapped filtering does funky things.
    # Makes smaller or larger textures and uses them, instead of distorting
    # the original.  Or something.
    glBindTexture( GL_TEXTURE_2D, textures[2] )
    glTexImage2D( GL_TEXTURE_2D, 0, GL_RGBA, textureSurface.get_width(), \
                  textureSurface.get_height(), 0, GL_RGBA, \
                  GL_UNSIGNED_BYTE, textureData )
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, \
                     GL_LINEAR_MIPMAP_NEAREST )
    glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR )
    gluBuild2DMipmaps( GL_TEXTURE_2D, GL_RGBA, textureSurface.get_width(), \
                       textureSurface.get_height(), GL_RGBA,
                       GL_UNSIGNED_BYTE, textureData )

    

def initGL():
    glEnable( GL_TEXTURE_2D )
    loadTextures()
    glShadeModel( GL_SMOOTH )
    glClearColor( 0.0, 0.0, 0.0, 0.0 )
    glClearDepth( 1.0 )
    glEnable( GL_DEPTH_TEST )
    glDepthFunc( GL_LEQUAL )
    glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST )

    global lightAmbient, lightDiffuse, lightPosition
    glLightfv( GL_LIGHT1, GL_AMBIENT, lightAmbient )
    glLightfv( GL_LIGHT1, GL_DIFFUSE, lightDiffuse )
    glLightfv( GL_LIGHT1, GL_POSITION, lightPosition )
    glEnable( GL_LIGHT1 )

    # All textures are blended with the current color.
    # So black draws 'em all black, white makes 'em normal,
    # grey makes 'em darker, we can make 'em look red or purple if
    # we want.  Nifty!
    glColor4f( 1.0, 1.0, 1.0, 0.5 )

def loadWorld():
    global tris
    verts = 0
    tri = []
    f = open( os.path.join( 'data', 'world.txt' ) )
    lines = f.readlines()
    f.close()
    for line in lines:
        vals = line.split()
        if len( vals ) != 5:
            continue
        if vals[0] == '//':
            continue

        vertex = []
        for val in vals:
            vertex.append( float( val ) )
        tri.append( vertex )
        verts += 1
        if verts == 3:
            tris.append( tri )
            tri = []
            verts = 0


def drawGL():
    global xpos, ypos, zpos
    global xrot, yrot, zrot
    global lookupdown
    global textures, filtr, tris


    xtrans = -xpos
    ytrans = -ypos - 0.25
    ztrans = -zpos
    sceneroty = 360.0 - yrot
    
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT )
    glLoadIdentity()
    glRotatef( lookupdown, 1.0, 0.0, 0.0 )
    glRotatef( sceneroty, 0.0, 1.0, 0.0 )
    glTranslatef( xtrans, ytrans, ztrans )
    glBindTexture( GL_TEXTURE_2D, textures[filtr] )

    for tri in tris:
        glBegin( GL_TRIANGLES )
        glNormal3f( 0.0, 0.0, 1.0 )
        
        glTexCoord2f( tri[0][3], tri[0][4] )
        glVertex3f( tri[0][0], tri[0][1], tri[0][2] )

        glTexCoord2f( tri[1][3], tri[1][4] )
        glVertex3f( tri[1][0], tri[1][1], tri[1][2] )

        glTexCoord2f( tri[2][3], tri[2][4] )
        glVertex3f( tri[2][0], tri[2][1], tri[2][2] )

        glEnd()


def handleKey( key ):
    global xrot, yrot, zrot
    global xpos, ypos, zpos
    global filtr

    if key == K_RIGHT:
        yrot -= 1.5
    elif key == K_LEFT:
        yrot += 1.5
    elif key == K_UP:
        xpos -= sin( yrot * piover180 ) * 0.1
        zpos -= cos( yrot * piover180 ) * 0.1
        
    elif key == K_DOWN:
        xpos += sin( yrot * piover180 ) * 0.1
        zpos += cos( yrot * piover180 ) * 0.1
    elif key == K_a:
        z -= 1.0
    elif key == K_z:
        z += 1.0

    elif key == K_f:
        filtr += 1
        if filtr > 2:
            filtr = 0

def main():

    videoFlags = OPENGL | DOUBLEBUF
    screenSize = (640,480)

    pygame.init()
    pygame.display.set_mode( screenSize, videoFlags )

    setSizeGL( screenSize )
    initGL()
    loadWorld()

    frames = 0
    ticks = pygame.time.get_ticks()
    while True:
        event = pygame.event.poll()
        if event.type == QUIT:
            break
        if event.type == KEYDOWN:
            handleKey( event.key )



        drawGL()
        pygame.display.flip()
        frames += 1

    print "FPS: %d" % ((frames * 1000) / (pygame.time.get_ticks() - ticks))



if __name__ == '__main__':
    main()
