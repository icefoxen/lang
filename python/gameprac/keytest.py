import pygame
from pygame.locals import *
import sys

a = pygame.display.set_mode( (320, 200) )
a.fill( (100, 100, 255) )

pygame.display.update()

while 1:
   for event in pygame.event.get():
      if event.type == QUIT:
         sys.exit()
      else: print `event`