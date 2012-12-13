import pygame
from pygame.locals import *
import sys, random
pygame.init()

MAPSIZE = 20

class tile:
   def __init__( self, image ):
      self.image = image
      self.size = image.get_rect()

map = []
b = []
for x in range( MAPSIZE ):
   b.append( ' ' )
   
for x in range( MAPSIZE ):
   map.append( b )
del b

screen = pygame.display.set_mode( (300, 300) )
tile1 = pygame.image.load( 'tile1.gif' ).convert()
tile2 = pygame.image.load( 'tile2.gif' ).convert()

# Initialize map
for x in range( MAPSIZE ):
   print "\n"
   for y in range( MAPSIZE ):
      t = random.randrange( 2 )
      print t,
      if t:
         map[x][y] = tile( tile1 )
      else:
         map[x][y] = tile( tile2 )

# Something's wrong... 
# It prints out whole columns of a solid color, not random patches.
# The columns match up with the LAST 20 values of t, as printed on the screen.
# let's force a recognizable pattern
map[0][0] = tile( tile1 )
map[1][1] = tile( tile2 )
map[2][2] = tile( tile1 )
map[3][3] = tile( tile2 )
map[4][4] = tile( tile1 )
map[5][5] = tile( tile2 )
# Now the first 6 columns alternate grey/red/grey/red/grey/red, even
# when the last values of t don't.  But I have no clue what's wrong.

cnt = 0
cnt2 = 0
for y in map:
   print y
   for x in y:
      screen.blit( x.image, (cnt*x.size[2], \
         cnt2*x.size[3]) )
      pygame.display.update()
      cnt += 1
   cnt2 += 1
   cnt = 0
# There is something REALLY wrong with this...  But I have no clue what.
# It has to be here, 'cause if it were in assigning the map, then my forcing
# different colors would create patches of color.  But what's messed up?
print map

pygame.display.update()

while 1:
   for event in pygame.event.get():
      if event.type in (QUIT, KEYDOWN):
         sys.exit()
