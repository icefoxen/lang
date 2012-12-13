# Weblog reporter.
# Practice.  Practical practice.
# Nifty.
# Gives an easy base to modify off of.
# 31/8/2002

import string
import sys

def cmpval( tuple1, tuple2 ):
   return cmp( tuple2[1], tuple1[1] ) # cmp() is compare

hostaccess = {}
urlaccess = {}

if len( sys.argv) < 2:
   print "Usage:", sys.argv[0], "<logfile>"
   sys.exit( 1 )

try: 
   file = open( sys.argv[1] )
except:
   print "Woah!", "Couldn't open file", sys.argv[1]
   sys.exit( 1 )

while 1:
   line = file.readline()
   if line:  # Modify the below to fit your logfile format
      (host, ident, user, time, offset, req, loc, httpber, success,
       bytes) = string.split( line )
      try:
         hostaccess[ host ] = hostaccess[ host ] + 1
      except:
         hostaccess[ host ] = 1
      try: 
         urlaccess[ loc ] = urlaccess[ loc ] + 1
      except:
         urlaccess[ loc ] = 1
   else:
      break

hosts = hostaccess.items()
hosts.sort( lambda f, s: cmp( f[1], s[1] ) )

for host, count in hosts:
   print host, ": ", count

urls = urlaccess.items()
urls.sort( cmpval )

for url, count in urls:
   print url, ": ", count