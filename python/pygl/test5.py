# Mmmm, display lists.
# Fast.  Modular.  Sexy.  What more do you want?

from OpenGL.GL import *
from OpenGL.GLU import *
import pygame
from pygame.locals import *

import os

translatex = -1.5
translatey = 0.0
translatez = -6.0

xrot = 0.0
yrot = 0.0
zrot = 0.0

xspeed = 0.0
yspeed = 0.0

textures = []
box = 0

blend = False
z = -5.0


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
    global textures
    textureFile = os.path.join( 'data', 'glass.bmp' )
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
    loadTextures()
    buildList()
    glEnable( GL_TEXTURE_2D )
    glShadeModel( GL_SMOOTH )
    glClearColor( 0.0, 0.0, 0.0, 0.0 )
    glClearDepth( 1.0 )
    glEnable( GL_DEPTH_TEST )
    glDepthFunc( GL_LEQUAL )
    glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST )


    # All textures are blended with the current color.
    # So black draws 'em all black, white makes 'em normal,
    # grey makes 'em darker, we can make 'em look red or purple if
    # we want.  Nifty!
    glColor4f( 1.0, 1.0, 1.0, 0.5 )
    glBlendFunc( GL_SRC_ALPHA, GL_ONE )


def buildList():
    global box
    box = glGenLists(1)
    glNewList( box, GL_COMPILE )
    
    glBegin( GL_QUADS )
    # Oops, normals are important
    glNormal3f( 0.0, 0.0, 1.0 )
    # Front face
    # Bottom left
    glTexCoord2f( 0.0, 0.0 )
    glVertex3f( -1.0, -1.0, 1.0 )
    # Bottom right
    glTexCoord2f( 1.0, 0.0 )
    glVertex3f( 1.0, -1.0, 1.0 )
    # Top right
    glTexCoord2f( 1.0, 1.0 )
    glVertex3f( 1.0, 1.0, 1.0 )
    # Top left
    glTexCoord2f( 0.0, 1.0 )
    glVertex3f( -1.0, 1.0, 1.0 )

    # Back face
    glNormal3f( 0.0, 0.0, -1.0 )
    # Bottom right
    glTexCoord2f( 1.0, 0.0 )
    glVertex3f( -1.0, -1.0, -1.0 )
    # Top right
    glTexCoord2f( 1.0, 1.0 )
    glVertex3f( -1.0, 1.0, -1.0 )
    # Top left
    glTexCoord2f( 0.0, 1.0 )
    glVertex3f( 1.0, 1.0, -1.0 )
    # Top left
    glTexCoord2f( 0.0, 0.0 )
    glVertex3f( 1.0, -1.0, -1.0 )

    # Top face
    glNormal3f( 0.0, 1.0, 0.0 )
    # Top left
    glTexCoord2f( 0.0, 1.0 )
    glVertex3f( -1.0, 1.0, -1.0 )
    # Bottom left
    glTexCoord2f( 0.0, 0.0 )
    glVertex3f( -1.0, 1.0, 1.0 )
    # Bottom right
    glTexCoord2f( 1.0, 0.0 )
    glVertex3f( 1.0, 1.0, 1.0 )
    # Top right
    glTexCoord2f( 1.0, 1.0 )
    glVertex3f( 1.0, 1.0, -1.0 )

    # Bottom face
    glNormal3f( 0.0, -1.0, 0.0 )
    # Top right
    glTexCoord2f( 1.0, 1.0 )
    glVertex3f( -1.0, -1.0, -1.0 )
    # Top left
    glTexCoord2f( 0.0, 1.0 )
    glVertex3f( 1.0, -1.0, -1.0 )
    # Bottom left
    glTexCoord2f( 0.0, 0.0 )
    glVertex3f( 1.0, -1.0, 1.0 )
    # Bottom right
    glTexCoord2f( 1.0, 0.0 )
    glVertex3f( -1.0, -1.0, 1.0 )
    
    glEnd()
    glEndList()

    
    

def drawGL():
    global xrot, yrot, zrot
    global xspeed, yspeed
    global z
    
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT )
    glLoadIdentity()

    #glTranslatef( 0.0, 0.0, z )

    #glRotatef( xrot, 1.0, 0.0, 0.0 )
    #glRotatef( yrot, 0.0, 1.0, 0.0 )
    #glRotatef( zrot, 0.0, 0.0, 1.0 )

    # Select the texture we want
    glBindTexture( GL_TEXTURE_2D, textures[0] )
    glCallList( box )
    #glBegin( GL_TRIANGLES )
    #glTexCoord2f( 0.0, 1.0 )
    #glVertex3f( 1.0, 0.0, 0.0 )
    #glTexCoord2f( 1.0, 0.0 )
    #glVertex3f( 0.0, 1.0, 0.0 )
    #glTexCoord2f( -1.0, 0.0 )
    #glVertex3f( -1.0, 0.0, 0.0 )
    #glEnd()

    xrot += xspeed
    yrot += yspeed


def handleKey( key ):
    global xrot, yrot, zrot
    global xspeed, yspeed, z
    global  blend

    if key == K_RIGHT:
        yspeed += 0.1
    elif key == K_LEFT:
        yspeed -= 0.1
    elif key == K_UP:
        xspeed += 0.1
    elif key == K_DOWN:
        xspeed -= 0.1
    elif key == K_a:
        z -= 1.0
    elif key == K_z:
        z += 1.0
        
    elif key == K_b:
        blend = not blend
        if blend:
            glEnable( GL_BLEND )
            # Not technically correct, but okay most of the time
            glDisable( GL_DEPTH_TEST )
        else:
            glDisable( GL_BLEND )
            glEnable( GL_DEPTH_TEST )

def main():

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
            handleKey( event.key )



        drawGL()
        pygame.display.flip()
        frames += 1

    print "FPS: %d" % ((frames * 1000) / (pygame.time.get_ticks() - ticks))



if __name__ == '__main__':
    main()
