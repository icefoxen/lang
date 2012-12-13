#!/usr/bin/python

from socket import *

msg = "GET http://www.google.com/ HTTP/1.0\r\nProxy-Connection: Keep-Alive\r\nProxy-Authorization: Basic cGhlYXRoOkAzYW50YXI="

s = socket( AF_INET, SOCK_STREAM )
s.connect( ('proxya.aub.edu.lb', 3128) )
s.send( msg )
s.shutdown( 1 )   # Close the sending side of the connection
data = s.recv( 2048 )  # Max 2k of data recieved
print data
