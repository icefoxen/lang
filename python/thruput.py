#!/usr/bin/python

import sys, time
from socket import *

THEPORT = 50000 + 42
BUFSIZE = 1024

def main():
   if len( sys.argv ) < 2:
      usage()
   if sys.argv[1] == '-s':
      server()
   if sys.argv[1] == '-c':
      client()
   else:
      usage()

def usage():
   sys.stdout = sys.stderr  # 'print' goes to stderr...
   print """
Usage:  (on host_A) thruput.py -s [port]
then:   (on host_B) thruput.py -c count host_A [port]"""
   sys.exit( 2 )  # sys.exit() 'cause it's also called if something goes wrong

def server():
   if len( sys.argv ) > 2:
      port = eval( sys.argv[2] )
   else:
      port = THEPORT
   s = socket( AF_INET, SOCK_STREAM )
   s.bind( ( '', port ) )  # Why blank string for IP addr?  localhost?
   s.listen( 1 )  # Accept and queue 1 connection
   print 'server ready...\n'
   while 1:
      conn, (host, remoteport) = s.accept()
      while 1:
         data = conn.recv( BUFSIZE )
         if not data: break
         print 'data recieved: ', len( data ), 'bytes'
         del data
      conn.send( 'OK\n' )
      conn.close()
      print 'Done with', host, 'port', remoteport

def client():
   if len( sys.argv ) < 4:
      usage()
   count = int( eval( sys.argv[2] ) )  # Make sure it's an int...
   host = sys.argv[3]
   if len( sys.argv ) > 4:
      port = eval( sys.argv[4] )
   else:
      port = THEPORT

   testdata = 'x' * (BUFSIZE - 1) + '\n'
   t1 = time.time()
   s = socket( AF_INET, SOCK_STREAM )
   t2 = time.time()
   s.connect( (host, port) )
   t3 = time.time()
   i = 0
   while i < count:
      i = i + 1
      s.send( testdata )
   s.shutdown( 1 )  # End the send side of the connection
   t4 = time.time()
   data = s.recv( BUFSIZE )
   t5 = time.time()

   print data
   print 'raw timers:', t1, t2, t3, t4, t5
   print 'Intervals:', (t2-t1), (t3-t2), (t4-t3), (t5-t4)
   print 'Total:', (t5-t1)
   print 'Throughput:', \
      round( (BUFSIZE * count * 0.001) / (t5-t1), 3),
   print 'K/sec'

main()
