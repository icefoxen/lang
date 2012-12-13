# mail tormenter?
# hmm...
# Not mine -came from: 
# http://www.networkcomputing.com/unixworld/tutorial/005/005.html
# 16/07/2002

import posix   # make posix system calls avaliable

def mailit( filename, subject, list ):  # The colon is important!
   # mail the file to each victim
   for victim in list:
      # make a shell mail command for this victim
      string = 'cat ' + filename + ' | mail -n -s ' + \
               `subject` + ' ' + victim
      print string  # Echo the command
      posix.system( string )  # Execute the command

usage = 'function: mailit( filename, subjectstring, list )'

# the `subject` call turns it in to a 'readable string representation
# which is apparently powerful, but here it only adds quote chars
# around the variable