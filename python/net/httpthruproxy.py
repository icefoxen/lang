#!/usr/bin/python
# A one-shot script demonstrating how to access a HTTP proxy server.
# Just add a header to the request saying:
# "Proxy-Authorization: Basic username:pass"
# with "username:pass" encoded in base 64.

from httplib import *
import base64

USER = raw_input( "Enter username: " )
PASS = raw_input( "Enter password: " )
authstring = USER + ':' + PASS

URL = raw_input( "Enter URL: " )
PROXY = raw_input( "Enter proxy name (IP addr, or www.foo.com): " )
PPORT = raw_input( "Enter proxy port: " )

authcode = base64.encodestring( authstring )
authheader = { 'Proxy-Authorization': 'Basic ' + authcode }

h = HTTPConnection( PROXY, PPORT )
print 'connection created'

h.connect()
print 'connection established'

h.request( 'GET', URL, '', authheader )
print 'request sent.'

r = h.getresponse()
print 'Response gotten...  Reading it may take a while.'

text = r.read()
print 'Response:\n' + text

h.close()
print 'connection closed'


f = file( 'response.txt', 'w' )
print 'file opened'

f.write( text )
print 'file written'

f.close()
print 'file closed'

print 'done'
