#!/bin/env python
# UDP echo server and client... ping, basically.

import sys
from socket import *

ECHO_PORT = 50000 + 7  # 7 is usual echo port
BUFSIZE = 1024

def main():
   """
Main function.  This processes the arguments and calls the
appropriate function for them.  That's all."""

   if len( sys.argv ) < 2:
      usage()
   if sys.argv[1] == '-s':
      server()
   if sys.argv[1] == '-c':
      client()
   else:
      usage()

def usage():
   """
Usage.  Prints out the quickhelp info."""

   sys.stdout = sys.stderr
   print """
Usage:  udpecho -s [port]          (server)
or:     udpecho -c host [port]     (client)"""
   sys.exit( 2 )

def server():
   """
Server.  Sets up a simple echo-server."""
   if len( sys.argv ) > 2:
      port = eval( sys.argv[2] )
   else:
      port = ECHO_PORT
   s = socket( AF_INET, SOCK_DGRAM )  # UDP datagram socket
   s.bind( ('', port) )
   print 'UDP echo server ready'
   while 1:
      data, addr = s.recvfrom( BUFSIZE )  # UDP is connectionless, so this
                                          # gives address info
      print 'server recieved', `data`, 'from', `addr`
      s.sendto( data, addr )  # Again, connectionless, so needs 'addr' info

def client():
   """
Client.  Reads from stdin and sends it to server."""
   if len( sys.argv ) < 3:
      usage()
   host = sys.argv[2]
   if len( sys.argv ) > 3:
      port = eval( sys.argv[3] )
   else:
      port = ECHO_PORT
   addr = ( host, port )
   s = socket( AF_INET, SOCK_DGRAM )
   s.bind( ('', 0) )
   print 'UDP echo client ready, reading stdin.'
   while 1:
      print 'input> ',
      line = sys.stdin.readline()
      if not line:
         break
      s.sendto( line, addr )
      data, fromaddr = s.recvfrom( BUFSIZE )
      print 'client recieved', `data`, 'from', `fromaddr`

main()
