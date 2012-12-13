from httplib import *
from base64 import encodestring

class ProxyConnection( HTTPConnection ):
   """
foo = ProxyConnection( proxyhost, port )  -> ProxyConnection

Only new method is prequest(), which sends a Basic Proxy-Authorization
request to proxyhost.
Get returned data back as usual via getresponse()
"""


   def prequest( self, method, url, (user, passwd), body=None ):
      """
prequest( method, url, (user, passwd), body=None ) -> None

This just adds an extra header to the request, offering HTTP Basic
Proxy-Authorization.

...Does not support extra headers.  Fix, once you find out how to 
join dictionaries.
"""

      self.authstring = user + ':' + passwd
      headers = { 'Proxy-Authorization': 'Basic ' + encodestring( self.authstring ) }
      self.request( method, url, body, headers )

