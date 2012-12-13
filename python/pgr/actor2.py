
class Player:
   def __init__( self, image ):
      self.images = []
      for x in range( 64 ):
         self.images.append( \
	    pygame.translate.rotate( image, - int( 5.625 * x) ) )
	 self.images[x].set_colorkey( (0, 0, 0), RLEACCEL )

      self.image = self.images[0]
      self.rect = self.image.get_rect()
      self.rect.move_ip( SCREENWIDTH / 2, SCREENHEIGHT / 2 )

      self.mass = 0.0
      self.thrust = 0.0
      self.maxspeed = 0.0
      self.rotate = 0.0

      self.speed = 0.0
      self.direction = 0.0
      self.x = 0.0
      self.y = 0.0
