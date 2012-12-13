import sys, string
from socket import *

BUFSIZE = 1024

FTP_PORT = 21
FTP_DATA_PORT = FTP_PORT + 49999

def main():
   hostname = sys.argv[1]
   control( hostname )

def control( hostname ):
   s = socket( AF_INET, SOCK_STREAM )
   s.connect( (hostname, FTP_PORT) )
   f = s.makefile( 'r' )
   r = None

   while 1:
      code = getreply( f )
      if code in ('221', 'EOF'): break
      if code == '150':
         getdata( r )
         code = getreply( f )
         r = None
      if not r:
         r = newdataport( s, f )
      cmd = getcommand()
      if not cmd: break
      s.send( cmd + '\r\n' )

nextport = 0
def newdataport( s, f ):
   global nextport
   port = nextport + FTP_DATA_PORT
   nextport = (nextport + 1) % 16
   r = socket( AF_INET, SOCK_STREAM )
   r.bind( (gethostbyname( gethostname() ), port) )
   r.listen( 1 )
   sendportcmd( s, f, port )
   return r

def sendportcmd( s, f, port ):
   hostname = gethostname()
   hostaddr = gethostbyname( hostname )
   hbytes = string.splitfields( hostaddr, '.' )
   pbytes = [ `port / 256`, `port % 256` ]
   bytes = hbytes + pbytes
   cmd = 'PORT ' + string.joinfields( bytes, ',' )
   s.send( cmd + '\r\n' )
   code = getreply( f )

def getreply( f ):
   line = f.readline()
   if not line: return 'EOF'
   print line,
   code = line[:3]
   if line[3:4] == '-':
      while 1:
         line = f.readline()
         if not line: break
         print line,
         if line[:3] == code and line[3:4] != '-':
            break
   return code

def getdata( r ):
   print '(Accepting data connection)'
   conn, host = r.accept()
   print '(Data connection accepted)'
   while 1:
      data = conn.recv( BUFSIZE )
      if not data: break
      sys.stdout.write( data )
   print '(End of connection)'

def getcommand():
   try:
      while 1:
         line = raw_input( 'ftp.py> ' )
         if line: return line
   except EOFError:
      return ''

main()
