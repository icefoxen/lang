import socket
import asyncore

class client( asyncore.dispatcher ):
   def __init__( self, host, path ):
      asyncore.dispatcher.__init__(self )
      self.path = path
      self.create_socket( socket.AF_INET, socket.SOCK_STREAM )
      self.connect( (host, 80) )
      self.buffer = 'GET %s HTTP/1.0\r\n\r\n' % self.path

   def handle_connect( self ):
      pass

   def handle_read( self ):
      data = self.recv( 8192 )
      print data

   def writable( self ):
      return (len(self.buffer) > 0 )

   def handle_write( self ):
      sent = self.send( self.buffer )
      self.buffer = self.buffer[sent:]
