# This tried to be a threaded wget-ish thing that could go through
# proxies.  It didn't work so well, for undetermined reasons.
# I learned to use wget right instead.
# *sigh...*  I suppose I should throw some documentation in now...
# ...anyhoo, I started this 'cause ftp transactions with wget were 
# being limited by the long time it took to request a file, not by
# network speed.  So I tried to make a multithreaded version to grab
# several files at once.
# Simon Heath
# 5/10/2002

import urlparse, re, thread, os
from mine.net import proxyconnect

currentthread = 1
MAXTHREAD = 8
threadlist = []
PROXY = ''
PORT = ''
USER = ''
PASSWD = ''


def seperate( URL ):
   """
seperate( string ) ->  (localpath, filename)

Takes a URL, say "http://foo.com/whatever/file.zip",
then returns ("/whatever/", "file.zip")
"""

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


def grabfile( url, proxy='', port='', user='', passwd='' ):
   """
grabfile( url, [proxy='', port='', user='', passwd=''] )
-> downloads file

Can grab a file through a proxy.
"""

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


def threadfunc( url, proxy='', port='', user='', passwd='' ):
   """
threadfunc( url, [proxy='', port='', user='', passwd=''] )
-> None

This function is run by the threads.  It increments the global 
semaphore, grabs the file, then decrements it and terminates the thread.
"""
   global currentthread
   currentthread += 1
   print 'New thread getting:\n', url
   grabfile( url, proxy, port, (user, passwd) )
   currentthread -= 1


def threadloop( loclist ):
   """
threadloop( loclist ) -> None

This manages the threads.  loclist is a list of files to get, like
['http://www.foo.com/here/one.html', 'http://www.bar.com/there/two.html']
It'll spawn threads up to the global var MAXTHREAD to grab these files.
"""
   while 1:
      if loclist == []:
         break
      if currentthread < MAXTHREAD:
         alpha = thread.start_new_thread( threadfunc, (loclist.pop(), PROXY, PORT, USER, PASSWD)  )


def usage():
   print """
Usage: tsnaffle.py proxy port user passwd file

I don't wanna make this fancier...  If you wanna leave out 
proxy, port, user, or passwd, just replace them with ''
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


if __name__ == '__main__':
   main()