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


def load_progs():
   "Loads the program data from the config file"
   f = open( 'programs.conf', 'r' )
   for line in f.readlines():
      line = line.strip()
      line = line.split( "\t" )
      if len( line ) == 2:
         PRG.append( Program( line[0], line[1] ) )
      elif len( line ) == 3:
         PRG.append( Program( line[0], line[1], load_image( line[2] ) ) )
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
         FIL.append( File( line[0], line[1] ) )
      elif len( line ) == 3:
         FIL.append( File( line[0], line[1], line[2] ) )
      else:
         raise "ACK!  Invalid config file: file.conf"
   f.close()

   # The program bar can NOT show more than 18 programs!!
   # 'cause that's how many icons will fit on the bar...
   if len( FIL ) > 18:
      raise "ACK!  Cannot load more than 18 files"


# This is NECESSARY so we don't destructively modify a reference to an image
def make_selected_image( image ):
   "Returns an image with a red border"
   return image

##############################################################################
## CLASSES

class Tab( pygame.sprite.Sprite ):
   """The little thingy in the corner that holds the file and program bars"""

   def __init__( self, image, image2 ):
      pygame.sprite.Sprite.__init__( self, self.containers )
      
      self.image_unclicked = image
      self.image_clicked = image2
      self.image = self.image_unclicked
      self.image.set_colorkey( (0, 0, 0), RLEACCEL )
      
      self.rect = self.image.get_rect()
      self.rect.left = SCREENRECT.left
      self.rect.bottom = SCREENRECT.bottom

      self.clicked = 0


   # These two are activated in the mainloop by MOUSEBUTTON events
   def click( self ):
      self.clicked = 1
      self.image = self.image_clicked

   def unclick( self ):
      self.clicked = 0
      self.image = self.image_unclicked


# TODO:  Make it so it expands horizontally when more than 18 icons are
# added!!!
class ProgramPanel( pygame.sprite.Sprite ):
   """A panel across the side of the screen that holds program icons"""

   # Init's the panel then draws the program icons on it.
   def __init__( self, image ):
      pygame.sprite.Sprite.__init__( self, self.containers )

      # XXX: Replace with a real image
      self.image = pygame.surface.Surface( (24, 432) )
      self.image.fill( (0, 0, 200) )
      
      self.rect = self.image.get_rect()
      self.rect.left = SCREENRECT.left
      self.rect.bottom = SCREENRECT.bottom - 24

      self.contents = PRG

      # Tiles the program icons along the bar
      for x in range( len( self.contents ) ):
         self.image.blit( \
            self.contents[x].image, (2, self.rect.height - 24 - (x * 24) ) )
         # We set the Program rect's to the right place, so we can easily tell
         # if someone's clicked in them.  See the 'click' function.
         self.contents[x].rect.left = self.rect.left + 2
         self.contents[x].rect.bottom = self.rect.bottom - 2 - (x * 24)

   # Must appear 24 pixels above the bottom of the screen, to avoid the tab.
   def toggle( self ):
      "Toggles whether the bar is shown or hidden"
      if self.rect.bottom == SCREENRECT.bottom - 24:
         self.rect.top = SCREENRECT.bottom
      else:
         self.rect.bottom = SCREENRECT.bottom - 24

   def click( self, loc ):
      """Is called when the program panel is clicked upon; launches the
appropriate app.  This takes advantage of the fact that a Program object
knows where it's icon is being displayed... even if it doesn't seem to
actually display by itself."""
      # See Program.execute() and the mainloop event handling for an
      # explination of these return values.
      for x in PRG:
         if x.rect.collidepoint( loc ):
            x.execute()

   def get_icon( self, loc ):
      for x in self.contents:
         if x.rect.collidepoint( loc ):
            return x


# Virtually identical to the ProgramPanel
class FilePanel( pygame.sprite.Sprite ):
   """A panel across the bottom of the screen that holds file icons"""

   # Init's the panel then draws the program icons on it.
   def __init__( self, image ):
      pygame.sprite.Sprite.__init__( self, self.containers )

      # XXX: Replace with a real image
      self.image = pygame.surface.Surface( (600, 24) )
      self.image.fill( (0, 0, 200) )
      
      self.rect = self.image.get_rect()
      self.rect.left = SCREENRECT.left + 24
      self.rect.bottom = SCREENRECT.bottom

      self.selected = pygame.surface.Surface( (20, 1) )
      self.selected.fill( (230, 230, 230) )
      self.unselected = pygame.surface.Surface( (20, 1) )
      self.unselected.fill( (0, 150, 220) )

      self.contents = FIL

      self.build_icons()


   # Must appear 24 pixels above the bottom of the screen, to avoid the tab.
   # The bar hides itself BELOW the screen.  Ideally, it would slide leftwards
   # all cool-like, but a) animation is hard, and b) sliding leftwards would
   # make things rather screwy for blitting the icons, since they use
   # self.rect.left to find the vertical position and if self.
   def toggle( self ):
      "Toggles whether the bar is shown or hidden"
      if self.rect.bottom == SCREENRECT.bottom:
         self.rect.top = SCREENRECT.bottom
      else:
         self.rect.bottom = SCREENRECT.bottom

   # Not as nice as it could be I think, but...
   # Has to have this to deal with the file.image changing when the image is
   # selected/deselected
   def build_icons( self ):
      "Tiles the file icons along the bar"
      for x in range( len( FIL ) ):
         self.image.blit( \
            self.contents[x].image, ( (x * 24) + 2, 2 ) )
         # We set the Program rect's to the right place, so we can easily tell
         # if someone's clicked in them.  See the 'click' function.
         self.contents[x].rect.left = self.rect.left + 2 + (x * 24)
         self.contents[x].rect.bottom = self.rect.bottom - 2

         # Blit the initial selection toggle
         self.image.blit( self.unselected, \
            (self.contents[x].rect.left - 24, 2) )


   # toggles the selection of the appropriate file, and if selected, blit a
   # little indicator-thingy
   def click( self, loc ):
      for x in self.contents:
         if x.rect.collidepoint( loc ):
            x.select()
            if x.selected:
               self.image.blit( self.selected, \
                  (x.rect.left - 24, 2) )
            else:
               self.image.blit( self.unselected, \
                  (x.rect.left - 24, 2) )

   def get_icon( self, loc ):
      for x in self.contents:
         if x.rect.collidepoint( loc ):
            return x

class Program:
   """Holds all the data and methods associated with a program"""

   def __init__( self, name, path, icon=None ):
      """__init__( name, path, icon=None ) -> program
name is the given name, path the path to the binary, icon an optional pygame
Surface object"""
      self.name = name
      self.path = path

      # This technically isn't good practice, since IMG['def_prog_icon'] isn't
      # actually created until the main() function.  But it's a nice handy way
      # of making sure I don't have to load the same default file many times.
      if icon:
         self.image = icon
      else:
         self.image = IMG['def_prog_icon']

      self.rect = self.image.get_rect()
      self.rect.right = SCREENRECT.right
      self.rect.bottom = SCREENRECT.bottom

      print "Program " + name + " loaded."

   # Guess.
   def execute( self ):
      args = ""
      for x in FIL:
         if x.selected:
            args += " " + x.path

      command = self.path + args
      os.system( command )
      
      # Again, this is bad, 'cause "term" isn't defined until the mainloop.
      # However, I believe the symmetry works better than os.system...
      # Well... it doesn't work, 'cause term isn't defined for this class...
      # I could do some namespace-wonking and fix it, but I'd be effectively
      # breaking the language.
      #Terminal.printterm( term, command )
      #Terminal.input( term, command )
      



class File:
   """Holds all the data and methods associated with a file bookmark"""

   def __init__( self, name, path, icon=None, selectedIcon=None ):
      """__init__( name, path, icon=None, selectedIcon=None ) -> file
name is the given name, path the path to the file, icon and selectedIcon are 
optional pygame Surface objects"""
      self.name = name
      self.path = path
      self.args = ""
      self.selected = 0

      # This technically isn't good practice, since IMG['def_file_icon'] isn't
      # actually created until the main() function.  But it's a nice handy way
      # of making sure I don't have to load the same default file many times.
      if not icon:
         icon = IMG['def_file_icon']

      self.image = icon

      self.rect = self.image.get_rect()
      self.rect.right = SCREENRECT.right
      self.rect.bottom = SCREENRECT.bottom

      print "File " + name + " loaded."

   def select( self ):
      """Selects the file.  A selected file will load into a program when it
starts"""
      self.selected = not self.selected 


class Status( pygame.sprite.Sprite ):
   """Status bar"""

   def __init__( self, icon=None ):
      pygame.sprite.Sprite.__init__( self, self.containers )
      
      self.image = pygame.surface.Surface( (600, 24) )
      self.image.fill( (0, 0, 200) )

      self.rect = self.image.get_rect()
      self.rect.right = SCREENRECT.right - 24
      self.rect.top = SCREENRECT.top
      
      # Copy image as backup
      self.bakimage = pygame.surface.Surface( (self.rect.width, \
         self.rect.height) )
      self.bakimage.blit( self.image, (0, 0) )

      self.font = pygame.font.Font( "dungeon.ttf", 16 )

      self.string = "This is Nessus.  --By Icefox"
      self.show_string()

   def show_string( self ):
      """Displays self.string"""
      # Second arg is whether or not to anti-alias.
      text = self.font.render( self.string, 1, (255, 255, 255) )
      # Reset image to what it was w/o text...
      self.image.blit( self.bakimage, (0, 0) )
      # This makes the text right-aligned
      spacing = self.rect.width - text.get_width() - 15
      # Blit baby, blit!
      self.image.blit( text, (spacing, 0) )


# Terminal needs something MEANINGFUL...  prog execution we can do from the
# stat bars...
class Terminal( pygame.sprite.Sprite ):
   """The main text-display.  'Tis simpler than I thought it would be.  Adding
scroll bars would be interesting..."""

   def __init__( self, icon=None ):
      pygame.sprite.Sprite.__init__( self, self.containers )
      
      self.image = pygame.surface.Surface( (600, 400) )
      self.image.fill( (0, 0, 0) )
      pygame.draw.rect( self.image, (0, 200, 0), \
         self.image.get_rect(), 1 )

      self.rect = self.image.get_rect()
      self.rect.left = SCREENRECT.left + 24
      self.rect.top = SCREENRECT.top + 24
      
      self.font = pygame.font.Font( "cour.ttf", 14 )

      self.cursorX = 4
      self.cursorY = 4

      self.blank = pygame.surface.Surface( (8, 18) )
      self.blank.fill( (0, 0, 0) )

      self.string = ""
      self.printterm( "Terminal> " )

   def printterm( self, string ):
      """Outputs the string to the terminal.  Handles newlines and
backspaces.  This is output ONLY."""
      # Handles it one char at a time...
      for x in string:
         # Test to see if the character is a newline
         if x == u'\r':
            self.cursorX = 6
            self.cursorY += 18
         # Test for a backspace
         elif x == u'\b':
            self.cursorX -= 8
            self.image.blit( self.blank, (self.cursorX, self.cursorY) ) 
	 # Test for tab
	 elif x == u'\t':
	    self.cursorX += 24
         # Else, print the char
         else:
	    # Render text,
            text = self.font.render( x, 0, (255, 255, 255) )
	    # Blit it,
            self.image.blit( text, (self.cursorX, self.cursorY) )
	    # Advance cursor
            self.cursorX += 8
	    # Make sure it's not advanced TOO far
            if self.cursorX > self.rect.width - 10:
               self.cursorX = 6
               self.cursorY += 18
	    # Prevent from being backspaced too far also
	    # Doesn't work as well as it should but...
	    elif self.cursorX < 6:
	       self.cursorX = 6
            # If writing overflows screen, reset it
            if self.cursorY > self.rect.height - 20:
               self.image.fill( (0, 0, 0) )
	       self.cursorY = 4

   def write( self, string ):
      """Displays user input and evaluates it."""
      for x in string:
         # Test for newline
         if x == u'\r':
	    self.input( self.string )
	    self.string = ""
	    self.printterm( "\rTerminal> " )
	 # Test for backspace
	 elif x == u'\b':
	    self.string = self.string[:-1]
	    self.printterm( x )
	 # Else, print
	 else:
            self.printterm( x )
            self.string += x


   def input( self, s ):
      """Handles commands given to the shell""" 
      # Splits at tabs, NOT SPACES!!
      prog = s.split( "\t" )
      print "inputted string = ", s
      args = ""
      # Build args
      for x in prog:
         if x == prog[0]:
            pass
         else:
            args += " " + x
      print "args = ", args
      # See if it's an existing prog definition
      for x in PRG:
         # If so, execute it
         if x.name == prog[0]:
	    print "Executing " + x.name
            x.execute()
            break
      # If not broken...
      self.printterm( "\r" + prog[0] + " is an invalid command" )
