# Static data for Nessus.
#
# Tooltips with the program and file name???  OR add name next to the icon...!
# I think tooltips + MIME-type icons would be better --smaller,
# toolbar-expansion.
#
# Also TODO: Build some way to add/remove programs and files...  Green status
# bars on the top and right for program functions?
#
# CLIPBOARD ACCESS.
#
# Ideas:
# Network programs, talk-like chat progs, telnet access, file sharing, shell
# interface, set-based FS, scripting(!?)
#
# Prettiness:  Nicer toolbar images, make them slide back instead of just
# dissapearing.
#
# Simon Heath
# 10/2/2003

import pygame
from pygame.locals import *

import sys, os


##########################################################################
## DATA

# CONSTANTS
WIDTH = 640
HEIGHT = 480
SCREENRECT = Rect( (0, 0, WIDTH, HEIGHT) )
DATAPATH = "./data/"
ICONSIZE = (20, 20)

PANEL_VERT = 0
PANEL_HORZ = 1

# GLOBALS
IMG = {}  # images
SND = {}  # sounds
PRG = []  # programs
FIL = []  # files


##########################################################################
## HELPER FUNCTIONS

# Utility functions to load data
def load_image( file ):
   "loads an image, prepares it for play"
   file = os.path.join( DATAPATH, file )
   try:
       print "Loading image: " + file
       surface = pygame.image.load( file ).convert()
   except pygame.error:
      raise SystemExit, \
         'Could not load image "%s" %s' % (file, pygame.get_error())
   return surface


def load_sound( name ):
   "Loads a sound and does error checking"
   class NoneSound:
      def play( self ): pass
   if not pygame.mixer or not pygame.mixer.get_init(): # If mixer is screwed...
      return NoneSound()   # Dummy class that'll pretty much act like a sound
      
   fullname = os.path.join( DATAPATH, name )
   try:
      print "Loading sound: " + fullname
      sound = pygame.mixer.Sound( fullname )
   except pygame.error, message:
      print 'Cannot load sound:', fullname
      raise SystemExit, message
   return sound


# XXX: How do we know what KIND OF OBJECTS to create, here??  Hardwire?
#def load_config():
#   """load_config( filename, global ) -> None
#Loads the options from the config file and sticks them into the global
#dictionary."""
#   f = open( 'programs.conf', 'r' )
#   for line in f.readlines():
#      line = line.strip()
#      line = line.split( "\t" )
#      if len( line ) == 2:
#         PRG.append( ProgramButton( line[0], line[1] ) )
#      elif len( line ) == 3:
#         PRG.append( ProgramButton( line[0], line[1], load_image( line[2] ) ) )
#      else:
#         raise "ACK!  Invalid config file: program.conf"
#   f.close()
#
#   # The program bar can NOT show more than 18 programs!!
#   # 'cause that's how many icons will fit on the bar...
#   if len( PRG ) > 18:
#      raise "ACK!  Cannot load more than 18 programs"


def load_progs():
   "loads the program config file"
   f = open( 'programs.conf', 'r' )
   for line in f.readlines():
      line = line.strip()
      line = line.split( "\t" )
      if len( line ) == 2:
         PRG.append( ProgramButton( line[0], line[1] ) )
      elif len( line ) == 3:
         PRG.append( ProgramButton( line[0], line[1], load_image( line[2] ) ) )
      else:
         raise "ACK!  Invalid config file: program.conf"
   f.close()

   # The program bar can NOT show more than 18 programs!!
   # 'cause that's how many icons will fit on the bar...
   if len( PRG ) > 18:
      raise "ACK!  Cannot load more than 18 programs"


def load_files():
   "Loads the file data from the config file"
   f = open( 'files.conf', 'r' )
   for line in f.readlines():
      line = line.strip()
      line = line.split( "\t" )
      if len( line ) == 2:
         FIL.append( FileButton( line[0], line[1] ) )
      elif len( line ) == 3:
         FIL.append( FileButton( line[0], line[1], load_image( line[2] ) ) )
      else:
         raise "ACK!  Invalid config file: file.conf"
   f.close()

   # The program bar can NOT show more than 18 programs!!
   # 'cause that's how many icons will fit on the bar...
   if len( FIL ) > 18:
      raise "ACK!  Cannot load more than 18 files"


##############################################################################
## CLASSES

# There are several classes.  Panel and Button are abstract classes that form
# the core of the interface.  Tab is just a simple GUI componant.  

class TopButton( pygame.sprite.Sprite ):
   """Any basic clickable button.  Is set directly onto the screen instead of
on a Panel."""

   def __init__( self, action, image, image2 ):
      pygame.sprite.Sprite.__init__( self, self.containers )
      
      self.image_unclicked = image
      self.image_clicked = image2
      self.image = self.image_unclicked
      self.image.set_colorkey( (0, 0, 0), RLEACCEL )
      
      self.rect = self.image.get_rect()

      self.clicked = 0

      # the action argument is what should happen when the button is clicked.
      # It can be anything; probably a predefined function or a lambda form.
      # Yay Lisp!!
      self.action = action

   def move( self, x, y ):
      self.rect.left = x
      self.rect.top = y

   # These two are activated in the mainloop by MOUSEBUTTON events
   def click( self ):
      self.clicked = 1
      self.image = self.image_clicked
      self.action()

   def unclick( self ):
      self.clicked = 0
      self.image = self.image_unclicked


#####  PANELS  ##############################################################

class Panel( pygame.sprite.Sprite ):
   """Displays a vertical or horizontal program panel with various icons on
it.  It should take care of invoking the icons appropriately."""
   
   def __init__( self, image, contents ):
      """Panel( image, contents ) -> panel
      image should be a pygame Surface object.  contents should be Button
      objects."""
      pygame.sprite.Sprite.__init__( self, self.containers )
      
      self.image = image 
      self.rect = self.image.get_rect()

      self.contents = contents
      self.hidden = 0


   def build_icons( self ):
      """Blits the icons onto the appropriate places on the bar"""
      iconX = self.rect.left + 2
      iconY = self.rect.bottom - 22
      for x in self.contents:
         # Find the X placement of the icon, left to right
         # Should never happen, but...
         if iconX < 2:
            iconX = 2
         # If X overflows, ching it back to the left and add another row
         # vertically.
         elif iconX > self.rect.width - 22:
            iconX = 2
            iconY += 24
         if iconY > self.rect.height - 2:
            self.extend_panel()

         self.image.blit( x.image, (iconX, iconY) )
         x.rect.left = iconX
         x.rect.top = iconY
         iconX += 24

   def move( self, x, y ):
      self.rect.left = x
      self.rect.top = y

   # Should be overridden
   # Make sure you add self.hidden = 0/1 when you do!!
   def show( self ):
      pass

   def hide( self ):
      pass

   def toggle( self ):
      if self.hidden:
         self.show()
      else:
         self.hide()

   def get_button( self, pos ):
      """Returns the icon that has been clicked, if any"""
      for x in self.contents:
         if x.rect.collidepoint( pos ):
            return x
      return None

   def click_button( self, pos ):
      """Call the clicked button's action() method"""
      for x in self.contents:
         if x.rect.collidepoint( pos ):
            x.action()

   def extend_panel( self ):
      # To be filled in later.
      print "Panel is supposedly extended"


class FilePanel( Panel ):
   """A panel that holds the file icons"""

   def __init__( self, contents ):
      Panel.__init__( self, IMG['file_panel'], contents )

      self.selected = pygame.surface.Surface( (20, 1) )
      self.selected.fill( (230, 230, 230) )
      self.unselected = pygame.surface.Surface( (20, 1) )
      self.unselected.fill( (0, 150, 220) )

      # If you mess with these, you will cause PROBLEMS.  Either the image is
      # shown before the icons are blitted onto it, or else the icons are
      # blitted onto it but the rect's are messed up and don't get moved with
      # the rest of it by the show() and hide() methods.
      self.show()
      self.build_icons()

   def build_icons( self ):
      Panel.build_icons( self )
      for x in self.contents:
         self.image.blit( self.unselected, (x.rect.left, x.rect.top - 1) )

   def show( self ):
      self.hidden = 0
      self.move( SCREENRECT.left + 24, SCREENRECT.bottom - self.rect.height, )

   def hide( self ):
      self.hidden = 1
      self.move( 10000, 10000 )

   def click_button( self, pos ):
      for x in self.contents:
         print pos
	 print x.rect
         if x.rect.collidepoint( pos ):
	    print x, "clicked"
            x.action()
	    if x.selected:
	       self.image.blit( self.selected, \
                  (x.rect.left, x.rect.top - 1) )
	    else:
	       self.image.blit( self.unselected, \
                  (x.rect.left, x.rect.top - 1) )


#####  BUTTONS  #############################################################

class Button:
   "A button that can be clicked and put on a panel."
   
   def __init__( self, name, data, image=None ):
      """Button( name, data, image=None ) -> Button
image is a pygame Surface.  name is the button's name.  data is a string
associated with the button."""

      # This technically isn't good practice, since IMG['def_prog_icon'] isn't
      # actually created until the main() function.  But it's a nice handy way
      # of making sure I don't have to load the same default file many times.
      if image:
         self.image = image
      else:
         self.image = IMG['def_prog_icon']

      self.rect = self.image.get_rect()

      self.name = name
      self.data = data

      print "Button " + name + " created"

   # Override
   def action( self ):
      pass


# XXX: Something is screwy with the constructors here.
class FileButton( Button ):
   """A button associated with a file path or URL that can be selected or
   unselected."""

   def __init__( self, name, data, image=None ):
      Button.__init__( self, name, data, image )

      self.selected = 0

   def action( self ):
      """Selectes the file.  A selected file will be appended to a program's
arguments when it starts."""
      self.selected = not self.selected


class ProgramButton( Button ):
   """A program that can be executed with the selected files as arguments"""

   def __init__( name, data, image=None ):
      Button( name, data, image )
      self.args = ""

   def action( self ):
      "Execute the program represented"
      args = self.args
      for x in FIL:  # Grab selected files from the global
         if x.selected:
            args += " " + x.path

      command = self.path + args
      print "Executing" + command
      os.system( command )
