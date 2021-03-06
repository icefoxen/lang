# NeHe tutorial 16!
# Fog, lovely fog!
# Watch it kill my graphics card!

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

filtr = False
light = False
blend = False
z = -5.0

lightAmbient  = ( (0.5, 0.5, 0.5, 1.0) )
lightDiffuse  = ( (1.0, 1.0, 1.0, 1.0) )
lightPosition = ( (0.0, 0.0, 2.0, 1.0) )

fogList = [GL_EXP, GL_EXP2, GL_LINEAR]
fogIndex = 0
fogColor = ( (0.8, 0.8, 0.8, 1.0) )


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
    global fogIndex
    glEnable( GL_TEXTURE_2D )
    loadTextures()
    glShadeModel( GL_SMOOTH )

    # Clear to the color of the fog
    glClearColor( 0.5, 0.5, 0.5, 1.0 )
    glFogi( GL_FOG_MODE, fogList[fogIndex] )
    glFogfv( GL_FOG_COLOR, fogColor )
    glFogf( GL_FOG_DENSITY, 0.35 )
    glHint( GL_FOG_HINT, GL_DONT_CARE )
    glFogf( GL_FOG_START, 1.0 )
    glFogf( GL_FOG_END, 5.0 )
    glEnable( GL_FOG )

    
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
    glBlendFunc( GL_SRC_ALPHA, GL_ONE )

    # This is just me being silly.
    #glBlendFunc( GL_ONE, GL_SRC_ALPHA )

    # Additive blending instead of alpha
    #glBlendFunc( GL_ONE, GL_ONE )

    # Mjolnir says this is the right way to do it.
    # I say it does strange things to my lighting.
    # Probably 'cause back-faces aren't lit.
    #glBlendFunc( GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA )
    

    #glPolygonMode( GL_FRONT, GL_FILL )
    #glPolygonMode( GL_BACK, GL_LINE )


def drawGL():
    global xrot, yrot, zrot
    global xspeed, yspeed
    global z
    global filtr
    
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT )
    glLoadIdentity()

    glTranslatef( 0.0, 0.0, z )

    glRotatef( xrot, 1.0, 0.0, 0.0 )
    glRotatef( yrot, 0.0, 1.0, 0.0 )
    #glRotatef( zrot, 0.0, 0.0, 1.0 )

    # Select the texture we want
    glBindTexture( GL_TEXTURE_2D, textures[filtr] )

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
    glTexCoord2f( 0.0, 1.5 )  # BWAHAHAHAH!
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

    xrot += xspeed
    yrot += yspeed


def handleKey( key ):
    global xrot, yrot, zrot
    global xspeed, yspeed, z
    global light, filtr, blend, fogIndex

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
        
    elif key == K_l:
        light = not light
        if not light:
            glDisable( GL_LIGHTING )
            print "Lights off!"
        else:
            glEnable( GL_LIGHTING )
            print "Lights on!"

    elif key == K_f:
        filtr += 1
        if filtr > 2:
            filtr = 0

    elif key == K_b:
        blend = not blend
        if blend:
            glEnable( GL_BLEND )
            # Not technically correct, but okay most of the time
            glDisable( GL_DEPTH_TEST )
        else:
            glDisable( GL_BLEND )
            glEnable( GL_DEPTH_TEST )

    elif key == K_g:
        fogIndex += 1
        if fogIndex > 2:
            fogIndex = 0
        glFogi( GL_FOG_MODE, fogList[fogIndex] )


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
