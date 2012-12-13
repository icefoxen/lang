#!/usr/bin/python
# Takes in an Ocaml list-thingy of options and builds a to-string function
# for them.  Or whatever.




def main():
   f = open( "foo.txt", 'r' )
   d = f.readlines()
   r = ''
   for x in d:
      str = x.strip()[2:]
      r += "| \"" + str + "\" -> " + str + "\n"
   f.close()
   f = open( "foo2.txt", 'w' )
   f.write( r )
   f.close()


if __name__ == '__main__':
   main()
