from socket import *
FILE = '/THINGY'
MESSAGE = 'HELLO WORLD!'
s = socket( AF_UNIX, SOCK_STREAM )
print 'socket', `s`, 'created'
s.connect( FILE )
print 'Connected to', FILE
s.send( MESSAGE )
print 'Sent:', MESSAGE
data = s.recv( 1024 )
s.close()
print 'Socket closed'
print 'Recieved data:', data
