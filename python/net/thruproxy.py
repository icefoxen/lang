from socket import *

LENGTH = 1024 * 1024 * 20  # 20 kb

msg = 'GET http://nice.purrsia.com/cgi-bin/ultimatebb.cgi?ubb=forum&f=42 HTTP/1.0\r\nProxy-Connection: Keep-Alive\r\nProxy-Authorization: Basic cGhlYXRoOkAzYW50YXI=\r\nCookie: ubber2452040.2359=Icefox&rollswagon&Icefox&45&00000715; login2452040.2359=09-24-2002%2006%3A22%20AM&2452542.0622; session2452040.2359=09-23-2002%2005%3A40%20AM&2452541.054\r\n\r\n'

# It's the 'Proxy-Authorization: Basic cGhlYXRoOkAzYW50YXI=\r\n\r\n'
# that does the trick.  The mess of letters at the end is 
# username:password converted to base64

s = socket( AF_INET, SOCK_STREAM )
s.connect( ('proxy.aub.edu.lb', 3128) )
s.send( msg )
s.shutdown(1)

finaldata = ''
while 1:
   data = s.recv( 2048 )
   if not data: break
   finaldata += data


f = open( 'recieved-data.txt', 'w' )
f.write( finaldata )
f.close()