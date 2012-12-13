import urlparse, re, thread, os
from mine.net import proxyconnect

currentthread = 1
MAXTHREAD = 5
threadlist = []
PROXY = ''
PORT = ''
USER = ''
PASSWD = ''


def seperate( URL ):
   a = URL
     # Get full url: 'http://foo.com/whatever/file.html'
   fullpath = urlparse.urlparse( a )
   fullpath = fullpath[2]
     # get url up to '/whatever/file.html'
   halfpath = re.match( '/.*/', fullpath ).group()
     # Get url up to '/whatever/'
   filename = fullpath.replace( halfpath, '' )
     # Get url WITHOUT '/whatever/', which ends up as just the filename.
     # Whew!
   return (halfpath, filename)
     # return it.


def grabfile( url, proxy='', port='', (user='', passwd='') ):
   path, file = seperate( url )
   if file == '':
      file = 'index.html'
   try:
      os.makedirs( path )
   except OSError:
      pass

   # Test for proxy...
   if proxy != '':
      conn = proxyconnect.ProxyConnection( proxy, port )
      print 'Requesting', url
      conn.prequest( 'GET', url, (user, passwd) )
   else:
      conn = proxyconnect.HTTPConnection( url )
      print 'Requesting', url
      conn.request( 'GET', url )

   print 'Downloading', url
   rcv = conn.getresponse()
   print 'Reading data from', url
   data = rcv.read()

   f = open( path + file, 'w' )
   f.write( data )
   f.close()


def threadfunc( url, proxy='', port='', (user='', passwd='') ):
   global currentthread
   currentthread += 1
   print 'New thread getting:\n', url
   grabfile( url, proxy, port, (user, passwd) )
   currentthread -= 1


def threadloop( loclist ):
   while 1:
      if loc == '':
         break
      if currentthread < threadmax:
         alpha = thread.start_new_thread( threadfunc, (loclist.pop(), PROXY, PORT, (USER, PASS))  )


def usage():
   print """
Usage: tsnaffle.py proxy port user passwd file

I don't wanna make this fancier...  If you wanna leave out 
proxy, port, user, pr passwd, just replace them with ''
"""


def main():
   global PROXY, PORT, USER, PASSWD
   import sys, string
   if len( sys.argv ) < 6:
      usage()
   else:
      PROXY = sys.argv[1]
      PORT = sys.argv[2]
      USER = sys.argv[3]
      PASSWD = sys.argv[4]
      fname = sys.argv[5]

      f = open( fname, 'r' )
      threadloop( string.split( f.read(), '\n' ) )  # Yay Lisp!


main()