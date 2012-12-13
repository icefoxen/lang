from socket import *

message = """What the heck is the point of this port?  It doesn't
seem to do anything, or even give any error messages.  Is is merely
there to confuse already-frustrated comp sci students when they mess
around trying to find a reason why AOL Instant Messenger persists in
not working???
If ye find this in the logs somewhere, I'd be obliged if ye can tell
me the reason.  I mean, you have ftp, ssh and telnet ports open, but
no program responds on them.  It's rather bewildering.  
snh07@aub.edu.lb
"""

s = socket( AF_INET, SOCK_STREAM )
print "socket created"

s.connect( ('proxyc.aub.edu.lb', 23) )
print "connected to port 23"

s.send( message )
print message + " sent"
s.shutdown( 1 )

print s.recv( 2048 )
