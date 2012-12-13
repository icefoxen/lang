#!/usr/bin/python

from socket import *

HOST=''
PORT=8888

s = socket( AF_INET, SOCK_STREAM )
s.bind( (HOST, PORT) )
s.listen( 1 )
conn, addr = s.accept()
data = conn.recv(1024)

print data
conn.send( "<HTML><BODY>Hi!</BODY></HTML>\n\n" )

conn.close()
