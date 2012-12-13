import os
from pygame import *

init()  # init pygame

def playsong( playlist ): 
   pllen = len( playlist )
   c = 0
   for song in playlist:
      c += 1
      try:
         mixer.music.load( song )
         mixer.music.play()
         print "Now playing [" + `c` + "/" + `pllen` + "] :", song
         while mixer.music.get_busy():
            print "Elapsed: " + `mixer.music.get_pos()` + "\r",
      except error:
         print "Unknown music file format:", song


def main():
   while 1:   
      print( "Enter music dir to play, r to replay [default current directory] or q to quit: " )
      instring = raw_input()

      if instring == "q" or instring == "Q": 
         break
      elif instring == "r" or instring == "R":
         mdir = os.getcwd()
      else:
         mdir = instring
         os.chdir( mdir )

      playlist = os.listdir( mdir )
      playsong( playlist )


if __name__ == '__main__':
   main()