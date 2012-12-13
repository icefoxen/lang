#!/bin/env python

from socket import *
ADDR = ( '192.168.5.26', 4004 )
MESSAGE = 'HELLO WORLD!'
s = socket( AF_INET, SOCK_STREAM )
print 'socket', `s`, 'created'
s.connect( ADDR )
print 'Connected to', ADDR
s.send( MESSAGE )
print 'Sent:', MESSAGE
data = s.recv( 1024 )
s.close()
print 'Socket closed'
print 'Recieved data:', data
