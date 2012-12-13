#!/usr/bin/python
# MZDMquickstat.py
# A CGI script that displays a webpage with a quick list of threads 
# a person is in, the name of the last poster, time of the last poster,
# and the thread starter.  Oh, and a comments field.
# Users enter their username and password, then are displayed a list of
# threads, plus options to add or remove threads.
#
# To this end, we have a MZDMThread class, which holds all the relevant
# information, a parser function, which (hopefully) grabs all the relevant
# information (still not quite sure how to do that), and a main function,
# which does all the interacting and displaying stuff.
#
# Simon Heath
# 30/1/2002

import urllib, re, pickle

# Debugging
import cgitb; cgitb.enable()

users = {}


####################################################################
## CLASSES

class MZDMThread:
   """This basically just contains all the thread information in a nice,
easy-to-manipulate format"""
   threadName = ""
   threadURL = ""
   threadAuthor = ""
   lastPoster = ""
   lastPostTime = ""
   userComment = ""

   def __init__( self, url ):
      self.threadURL = url
      self.parse( self.grab( url ) )


   def grab( self, url ):
      """Grabs and returns the thread page.
Uses urllib.  Why does access-by-URL always seem like cheating?"""
      # XXX This single call is what makes it take a long time...
      conn = urllib.urlopen( url )
      dat = conn.read()
      conn.close()
      return dat

   def parse( self, str ):
      """parse( str ) -> None
Takes thread page contents as an argument and grabs out all the relevant
information, then assigns it to the appropriate class variables.
Uses the Screaming Horde of Regexps method.  'Tis surprisingly effective.
Let's just hope the Nice doesn't undergo any major changes.  But it should be
able to translate to PHP fairly easily.""" 

      # Find the topic
      topic = re.compile( r"Topic: .*" ).search( str ).group()
      # Chop out fragments at beginning and end 
      self.threadName = topic[7:][:-11] 

      # Find the author
      # Rather brute-force match; the re.M second argument means "Multiline"
      author = re.compile( \
         r"<FONT SIZE=\"2\" .*><B>\n.*\n</B></font>", re.M )\
	 .search( str ).group()
      # Chop out fragments at beginning/end
      self.threadAuthor = author[64:][:-12]  

      self.lastPoster = "Not implemented yet"
      self.lastPostTime = "Not implemented yet"


class User:
   """Hangs on to the username, password, and threads.
If I ever add any customization settings or anything, those will also go
here."""
   username = ""
   password = ""
   threads = []
   
   def __init__( self, u, p ):
      self.username = u
      self.password = p

   def addthread( self, url ):
      # XXX
      # It simply will NOT let me do self.threads.append( MZDMThread( url )
      # No clue why, since it does it fine in interactive mode.
      # ...okay, now it's not even adding it this way.  Even though IT DID
      # BEFORE.
      a = MZDMThread( url )
      self.threads.append( a )
      return `self.threads`


   def delthread( self, url ):
      for x in range( len( self.threads ) - 1 ):
         if self.threads[x].threadURL == url:
	    del( self.threads[x] )

   # Return thread info in an HTML table
   def formatthreads( self ):
      response = """
<table width="95%">
<tr>
 <td width="20%">Thread</td>
 <td width="20%">Author</td>
 <td width="20%">Last Poster</td>
 <td width="20%">Last Post Time</td>
 <td width="20%">Comment</td>
</tr>"""
      # Build table
      for x in self.threads:
         response += "<tr><td><a href=\"" + x.threadURL + "\">"
	 response += x.threadName + "</a></td>"
	 response += "<td>" + x.threadAuthor + "</td>"
	 response += "<td>" + x.lastPoster + "</td>"
	 response += "<td>" + x.lastPostTime + "</td>"
	 response += "<td>" + x.userComment + "</td></tr>"
      response += "</table><br />"
      return response

########################################################################
## UTILITY FUNCTIONS


# "pickle" is the Python library's way of storing arbitrary objects as text
# data.  'Tis quite handy.

def getusers():
   """Unpickles and loads the user database"""
   global users
   users = pickle.load( open( '/var/tmp/MZDMqsUsers', 'r' ) )

def saveusers():
   """Pickles and saves the user database in /var/tmp/MZDMqsUsers"""
   global users
   pickle.dump( users, open( '/var/tmp/MZDMqsUsers', 'w' ) )


def accessAccount( user, passwd ):
   """Checks to see if an account is valid, if so, returns the threads"""
   global users
   if users.__contains__( user ) and users[user].password == passwd:
      # Print out threads and such...
      response = users[user].formatthreads()
      # Print out "Add thread" form 
      response += """
<br />
<form action="/cgi-bin/MZDMquickstat.py">
<input type="hidden" name="command" value="AddThread" />
<input type="hidden" name="name" value=\"""" + user + """" />
<input type="hidden" name="pass" value=\"""" + passwd + """" />
<b>Add Thread:</b> <input size="48" maxlength="128" name="thread" />
<input type="submit" name="Add Thread" /><br />
Adding a new thread may take a while...
</form><br />
"""
      return response

   else:
      return "<h2>Error: Invalid username/password</h2>"

def addThread( user, passwd, url ):
   """Checks to see if an account is valid, if so, adds the thread."""
   global users
   if users.__contains__( user ) and users[user].password == passwd:
      response = users[user].addthread( url )
      saveusers()
      return response + "<br />User " + user + " has added thread " + url
   else:
      return "<h2>Error: Invalid username or password.</h2>"


def newAccount( user, passwd ):
   """Creates a new account"""
   global users 
   # Check to see if user exists
   if not users.__contains__( user ):
      users[user] = User( user, passwd )
      saveusers()
      return "<h2>User " + user + " created. </h2>"
   else:
      return "<h2>Error: User already exists.</h2>"


########################################################################
## MAIN FUNCTION


def main():
   """Main CGI driver"""
   import cgi
   global users
   getusers()

   form = cgi.FieldStorage()  # Holds the field vars

   response = """Content-Type: text/html

<html>
<head>
<title>MZDM Quickcheck</title>
</head>

<body>
"""

   # Actual logic starts here

   # Error checking --if there's a problem with the values, do nothing.
   try:
      givenname = form['name'].value
   except:
      givenname = ""
   try:
      givenpass = form['pass'].value
   except:
      givenpass = ""
   try:
      giventhread = form['thread'].value
   except:
      giventhread = ""
  
   # If the user wants to access an account...
   if form['command'].value == "AccessAccount":
      response += accessAccount( givenname, givenpass ) 
   # Else if the user wants a new account..
   elif form['command'].value == "NewAccount":
      response += newAccount( givenname, givenpass )
   elif form['command'].value == "AddThread" and giventhread != "":
      response += addThread( givenname, givenpass, giventhread )
      response += "Adding thread " + giventhread + ", this may take a while."
      response += "<br />\n"
      response += "<a href=\"/cgi-bin/MZDMquickstat.py?name=" + givenname +\
	 "&pass=" + givenpass + "&command=AccessAccount" + "\">Back to Main"\
	 + "</a><br>\n"
      saveusers()
   # Error catching
   else: 
      response += "<h1>IMPOSSIBLE ERROR: No command given</h1>"
      response += "Make sure you're coming from the right page."
      

   response += " </body> </html>"
   print response
   


# Pages: Login/new account, status.
# So... if name/pass given and checks out, yer logged in and shown the status
# page.  The name/pass stays in the form box and is submitted each time.  I
# think that could work.
# OR, user logs in and is sent a cookie with the confirmation page.  Each
# request checks to see if the cookie exists, if so, it displays the
# appropriate page.

main()

