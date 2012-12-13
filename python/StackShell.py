#!/usr/bin/python
# StackShell.py
# A stack-based shell.  This is just a prototype program, to see
# how it works.
# ...ye gods.  I'm building a freakin' interperater!!
#
# TODO: if/then, for-loops, functions.  These will all need some
# sort of grouping mechanism, a la PS
# I/O redirection and file access would also be very nice.
# Some sorta list-like data structure to enable Python-like for loops?
# Improve parse_input() --lexer
# 
# Command-line history
# recall func --pops an item and lets you edit it
#
# BUGS: For some reason, it doesn't set the environment vars while executing a
# script.
#
# Simon Heath
# 21/1/2002

import sys, os

stack = []        # Argument stack
funcs = {}        # Function list --Contains refs to all stack funcs, private
user_funcs = {}   # User-defined functions --yay lambda!!
os.environ        # Environment variables


# STACK OPERATIONS
# Operations that are avaliable to the user to manipulate the stack

def pop():
   try:
      stack.pop()
   except:
      print "Error: stack underflow!"

def dup():
   try:
      item = stack.pop()
      stack.append( item )
      stack.append( item )
   except:
      print "Error: stack underflow!"

def rot():
   try:
      item = stack.pop()
      stack.insert( len( stack ) - 2, item )
   except:
      print "Error: stack underflow!"

def swap():
   try:
      item = stack.pop()
      stack.insert( len( stack ) - 1, item )
   except:
      print "Error: stack underflow!"

def over():
   swap()
   dup()
   rot()

def clear():
   global stack
   stack = []

def rem():
   """Removes an item of arbitrary depth from the stack"""
   try:
      x = stack.pop()
      del( stack[ int( x ) ] )
   except:
      print "Error: stack underflow!"

def depth():
   stack.append( float( len( stack ) ) )


# SHELL UTILITY FUNCTIONS
# Functions like iteration, execution, variable access...


def exit():
   print "Bye!"
   sys.exit( 0 )

def help():
   print\
"""This is a simple stack-based shell.  Commands are based on Forth
and Postscript.  They include:
add, sub, mul, div, mod, help, exit, over, swap, rot, dup, pop, clear, remove,
depth, var, showenv, ex
Anything else is treated as data and pushed onto the stack.
To force something to be data, prefix it with a \.  For instance, typing \pop
will push "pop" onto the stack.
A semicolon (;) denotes a comment; a comment continues to the end of the line.
There are two data types: Items and numbers.  All numbers are represented as
doubles.
To bind a variable, type the name, the value and the 'var' command.
To execute a program, enter the arguments, then the name, then the 'ex'
command.
"""

# Mathematical operators
def add():
   try:
      stack.append( stack.pop() + stack.pop() )
   except:
      print "Error: stack underflow!"

def sub():
   try:
      stack.append( stack.pop() - stack.pop() )
   except:
      print "Error: stack underflow!"

def mul():
   try:
      stack.append( stack.pop() * stack.pop() )
   except:
      print "Error: stack underflow!"

def div():
   try:
      stack.append( stack.pop() / stack.pop() )
   except:
      print "Error: stack underflow!"

def mod():
   try:
      stack.append( stack.pop() % stack.pop() )
   except:
      print "Error: stack underflow!"

def eq():
   try:
      stack.append( stack.pop() == stack.pop() )
   except:
      print "Error: stack underflow!"


def var():
   """Binds a new environment variable"""
   try:
      x = stack.pop()
      y = stack.pop()
      os.environ[ y ] = x
   except:
      print "Error: stack underflow!"

def showvars():
   """Shows all environment variables"""
   x = os.environ.keys()
   for i in x:
      print i, ":", os.environ[i]

def delvar():
   """Deletes an environment variable"""
   try:
      v = stack.pop()
   except:
      print "Error: stack underflow!"
   try:
      del( os.environ[ v ] )
   except:
      print "Error: var", v, "does not exist!"


def ex():
   """Executes a program"""
   arglist = ""
   try:
      for x in stack:
         arglist = `x` + " " + arglist
      clear()
      os.system( arglist )
   except:
      print "Error: check your args are compatable..."

def join():
   """Joins two symbols on the stack"""
   try:
      x = str( stack.pop() )
      y = str( stack.pop() )
      stack.append( y + x )
   except:
      print "Error: stack underflow!"

# Build function dictionary
funcs = {
   'join':join,
   'eq':eq,
   'delvar':delvar,
   'showvars':showvars,
   'ex':ex,
   'var':var,
   'rem':rem,
   'depth':depth,
   'mod':mod,
   'add':add,
   'sub':sub,
   'mul':mul,
   'div':div,
   'help':help,
   'exit':exit,
   'quit':exit,
   'over':over,
   'swap':swap,
   'rot':rot,
   'dup':dup,
   'pop':pop,
   'clear':clear
}

# PRIVATE UTILITY FUNCTIONS
# Helper functions that the user can NOT see...

def eval_stack( stk ):
   """Evaluates a stack, converting and pushing all the args and evaluating
all functions."""
   global stack
   for item in stk:
      if item == '':                     # Empty string is equal to ' '
         stack.append( " " )
      elif item[0] == '\\':              # If item is a literal, push it
         stack.append( item[1:] )

      elif item.isdigit():               # If it's a number, push a number.
         stack.append( float( item ) )

      elif funcs.has_key( item ):        # If item is a function, exec it
         funcs[item]()

      elif user_funcs.has_key( item ):   # if it's a user-defined function...
         user_funcs[item]()

      elif os.environ.has_key( item ):   # If it's a var, eval it
         stack.append( os.environ[item] )

      else:                              # Otherwise it's an arg; push it.
         stack.append( item )


def parse_input( s ):
   """Parse an input string --filter out comments and tokenize"""
   # Really MUST improve this...
   cstart = s.find( ";" )  # Find start of comments
   if cstart >= 0:
      s = s[:cstart] 
   s = s.split( ' ' )
   return s

def eval_script( file ):
   """Loads and evaluates a script with the given filename"""
   try:
      f = open( file, 'r' )
      data = f.read()
      f.close()
      data = data.strip()  # Strip newlines
      data = parse_input( data )
      eval_stack( data )
   except:
      print "Error: no such file:", file

def debug():
   """Invokes the underlying Python interperater"""
   while 1:
      exec( raw_input( '>>> ') )

funcs['debug'] = debug

# MAIN SHELL

def main():
   """Mainloop"""
   global stack

   if len( sys.argv ) > 1:  # If it's passed a script at command line, exec it.
      eval_script( sys.argv[1] )
      exit()

   else:
      # exec startup-script 
      eval_script( os.environ['HOME'] + "/.ssrc" )
      prompt = ">> "
      if os.environ.has_key( 'PS1' ):  # Grab prompt
         prompt = os.environ['PS1']
      print "Welcome to StackShell prototype, v. 0.1\nBy Simon Heath\n"
      while 1:  # Grab the input, parse it, and evaluate it
         print "Stack: ", stack 
	 s = raw_input( prompt )
         s = parse_input( s )
         eval_stack( s )

main()
