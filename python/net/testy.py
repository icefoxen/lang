#!/usr/bin/python
from socket import *

msg = '\x00\x00\x04\x4c\x3f\xea\x31\x3c\xf4\xfa\x85\x72\x00\x00\x00\x03\x00\x32\x00\x2e\x00\x30'

target = '192.168.5.45'
targetport = 1266

s = socket( AF_INET, SOCK_DGRAM )
s.connect( (target, targetport) )
print "Connected"
s.send( msg )
print "Sent"
while 1:
   d = s.recv( 1024 )
   print d
   if not d: break
print "Done"
