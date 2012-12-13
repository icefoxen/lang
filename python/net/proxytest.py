#!/bin/env python

from socket import *

msg = "GET http://www.eyrie.net/UF/FI/wlg.txt HTTP/1.0\r\nProxy-Authorization: Basic cGhlYXRoOkAzYW50YXI="

s = socket( AF_INET, SOCK_STREAM )
s.connect( ('proxy.aub.edu.lb', 3128) )
print 'connected'

s.send( msg )
print 'request sent'

s.shutdown( 1 )   # Close the sending side of the connection
print 'ready to recieve'

data = s.recv( 2048 )  # Max 2k of data recieved
print 'data recieved'

print data