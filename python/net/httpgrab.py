# This wonderful little thing grabs a webpage through a HTTP proxy,
# using Python's httplib module.  It then writes it out to a file.
# Has command line arguments to handle different proxies and 
# username/passwords, as well as different output files.
# Beautiful, ne?
# Simon Heath
# 19/09/2002


from httplib import *
import base64, sys


##################### INTERFACE FUNCTIONS ###############

def main():
   if len( sys.argv ) >= 4:
      connect()
   else:
      usage()


def usage():
   print """
Usage:  
httpgrab.py url username password [proxy=proxy.foo.com port#] [outputfile]
"""
   sys.exit( 1 )


##################### CONNECTION OPTIONS ###############
try:
   URL = sys.argv[1]
   USER = sys.argv[2]
   PASS = sys.argv[3]
except IndexError:   # If args not given, print usage
   usage()

PROXY = 'proxy.aub.edu.lb'
PROXYPORT = 3128
OUTPUT = 'output.txt'


##################### ARG PROCESSING ######################


if len( sys.argv ) > 4:
   if sys.argv[4][:6] == 'proxy=':  # If proxy settings given...
      PROXY = sys.argv[4][6:]
      PROXYPORT = sys.argv[5]
      if len( sys.argv ) > 6:       # If proxy and output file given...
         OUTPUT = sys.argv[6]
   else:  # Else if proxy settings not given, use default
      OUTPUT = sys.argv[4]
else:     # No optional settings given, use default.
   OUTPUT = 'output.txt'


if URL[:4] not in ('http', 'ftp:', 'goph'):
   URL = 'http://' + URL




##################### AUTH PROCESSING ####################

authstring = USER + ':' + PASS

authcode = base64.encodestring( authstring )
authheader = { 'Proxy-Authorization': 'Basic ' + authcode }


##################### ACTUAL CONNECTION DEFINITION #######

def connect():
   h = HTTPConnection( PROXY, PROXYPORT )
   print 'Connection made to', PROXY + ':' + `PROXYPORT`

   h.connect()
   print 'connection accepted'

   h.request( 'GET', URL, '', authheader ) # adds authheader to request
   print 'request sent for', URL

   r = h.getresponse()
   print 'Response gotten...  Reading it may take a while.'

   text = r.read()
   print 'Response read'

   h.close()
   print 'Connection closed'


   f = file( OUTPUT, 'w' )
   print 'file "' + OUTPUT + '" opened'

   f.write( text )
   print 'file written'

   f.close()
   print 'file closed'

   print 'done'



if __name__ == '__main__':
   main()