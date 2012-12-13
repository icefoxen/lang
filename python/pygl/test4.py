# Nehe tutorial 7!
# Note that blending is not real transparency;
# Light will not shine through surfaces!

from OpenGL.GL import *
from OpenGL.GLU import *
import pygame, pygame.image, pygame.key
from pygame.locals import *

import os, random

textures = []
stars = []
twinkle = True
zoom = -15.0
tilt = 90.0
spin = 0.0
maxStars = 5

class Star:
    def __init__( self, index ):
        self.angle = 0.0
        self.index = index
        self.max = maxStars
        self.dist = (1.0 * index / maxStars) * 5.0
        self.r = random.randrange( 0, 256 )
        self.b = random.randrange( 0, 256 )
        self.g = random.randrange( 0, 256 )

    def draw(self):
        glBegin( GL_QUADS )
        glTexCoord2f( 0.0, 0.0 )
        glVertex3f( -1.0, -1.0, 0.0 )
        glTexCoord2f( 1.0, 0.0 )
        glVertex3f( 1.0, -1.0, 0.0 )
        glTexCoord2f( 1.0, 1.0 )
        glVertex3f( 1.0, 1.0, 0.0 )
        glTexCoord2f( 0.0, 1.0 )
        glVertex3f( -1.0, 1.0, 0.0 )
        glEnd()

    def setColor( self ):
        glColor4ub( self.r, self.g, self.b, 255 )

    def orient( self ):
        global zoom, tilt, twinkle, stars
        glLoadIdentity()
        glTranslatef( 0.0, 0.0, zoom )
        glRotatef( tilt, 1.0, 0.0, 0.0 )
        glRotatef( self.angle, 0.0, 1.0, 0.0 )
        glTranslatef( self.dist, 0.0, 0.0 )
        glRotatef( -self.angle, 0.0, 1.0, 0.0 )
        glRotatef( -tilt, 1.0, 0.0, 0.0 )
        if twinkle:
            self.r = stars[self.max - self.index - 1].r
            self.g = stars[self.max - self.index - 1].g
            self.b = stars[self.max - self.index - 1].b
            self.setColor()
            self.draw()
        glRotatef( spin, 0.0, 0.0, 1.0 )


    def update( self ):
        global spin
        self.orient()
        self.setColor()
        self.draw()
        spin += 0.01
        self.angle += 1.0* self.index / self.max
        self.dist -= 0.01
        if( self.dist < 0.0 ):
            self.dist += 5.0
            self.r = random.randrange( 0, 256 )
            self.g = random.randrange( 0, 256 )
            self.b = random.randrange( 0, 256 )




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
    textureFile = os.path.join( 'data', 'star.bmp' )
    textureSurface = pygame.image.load( textureFile )
    textureData = pygame.image.tostring( textureSurface, 'RGBX', 1 )

    textures = glGenTextures( 2 )

    glBindTexture( GL_TEXTURE_2D, textures[0] )
    glTexImage2D( GL_TEXTURE_2D, 0, GL_RGBA, textureSurface.get_width(), \
                  textureSurface.get_height(), 0, GL_RGBA, \
                  GL_UNSIGNED_BYTE, textureData )
    # Nearest filtering is just literal translation
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR )
    glTexParameterf( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR )

    

def initGL():
    glEnable( GL_TEXTURE_2D )
    loadTextures()
    glShadeModel( GL_SMOOTH )
    glClearColor( 0.0, 0.0, 0.0, 0.0 )
    glClearDepth( 1.0 )
    glDepthFunc( GL_LEQUAL )
    glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST )


    #glColor4f( 1.0, 1.0, 1.0, 0.5 )
    glBlendFunc( GL_SRC_ALPHA, GL_ONE )
    glEnable( GL_BLEND ) 
    #glEnable( GL_DEPTH_TEST )
    for x in range( 2000 ):
        stars.append( Star( x ) )

def drawGL():
    global stars
    
    glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT )
    glLoadIdentity()
    glBindTexture( GL_TEXTURE_2D, textures[0] )
    for x in stars:
        x.update()


def handleKey( key ):
    global tilt, zoom, twinkle

    #if key == K_RIGHT:
    #    yspeed += 0.1
    #elif key == K_LEFT:
    #    yspeed -= 0.1
    if key == K_UP:
        tilt += 2.0
    elif key == K_DOWN:
        tilt -= 2.0
    elif key == K_a:
        zoom += 0.5
    elif key == K_z:
        zoom -= 0.5

    elif key == K_t:
        twinkle = not twinkle


def main():

    videoFlags = OPENGL | DOUBLEBUF
    screenSize = (640,480)

    pygame.init()
    pygame.display.set_mode( screenSize, videoFlags )
    pygame.key.set_repeat( 100, 30 )
    random.seed()

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
