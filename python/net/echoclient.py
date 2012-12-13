import socket

host = '192.168.5.26'
port = 2222

s = socket.socket( socket.AF_INET, socket.SOCK_STREAM )
s.connect( (host, port) )
s.send( 'Hello, old chap, how\'s life?' )
data = s.recv( 1024 )
s.close()
print 'Recieved:', `data`