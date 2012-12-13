#!/bin/env python

from socket import *
ADDR = ( '192.168.5.26', 4004 )
s = socket( AF_INET, SOCK_STREAM )
print 'Socket', `s`, 'created'
s.bind( ADDR )
print 'Socket bound.  Name is: [', s.getsockname(), ']'
s.listen( 1 )
conn, addr = s.accept()
print 'Connected by', addr
while 1:
   data = conn.recv( 1024 )
   if not data: break
   print 'Data recieved:', data
   message = 'Server>' + data
   conn.send( message )
   print 'Data sent:', data
conn.close()
print 'Connection', `conn`, 'closed'
