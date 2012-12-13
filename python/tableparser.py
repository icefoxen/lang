#!/usr/bin/python
# Experimenting with table-driven LL(1) parsing.
# Or something.
#
# Simon Heath
# 26/2/2005


# So.  The idea of this is basically a recursive-descent parser,
# but instead of a bunch of mutually-recursive functions that
# build structures based on what symbol is next and what called what how,
# it's a big loop engine that looks up actions and expected symbols
# in a table.
#
# The syntax is VERY simple.  Lisp arithmatic.  (+ 3 (- 5 4)), basically.
# We'll get more complex as we go on.

TABLE = []


def tokenize( str ):
   return str.split()

def resolveSymbol( str ):
   if str == '(':
      return "LPAREN"
   elif str == ')':
      return "RPAREN"
   elif str == '+':
      return "ADD"
   elif str == '-':
      return "SUB"
   elif str == '*':
      return "MUL"
   elif str == '/':
      return "DIV"
   elif str.isdigit():
      return str
   else:
      raise "LEX ERROR: %s is not valid!" % str

def lex( lst ):
   return map( resolveSymbol, lst ) + ["EOF"]

def makeParsingContext( str ):
   c = lex( tokenize( str ) )
   return { 'stream' : c, 'idx' : 0 }

def getNext( c ):
   stream = c['stream']
   idx = c['idx']
   n = stream[idx]
   c['idx'] += 1
   return n

def peekNext( c ):
   return c['stream'][ c['idx'] ]

# States: just parsed number, just parsed symbol
# ...trying to write this at 4 am is pure folly.
# The absyn tree is trivial: Python list, operation name at the start,
# then various values/exprs.
def driver( context ):
   symbol = getNext( context )
   



def parseExpr( c ):
   a = getNext( c )
   if a.isdigit():
      return int( a )
   elif a == 'LPAREN':
      return beginExpr( c )
   elif a == 'EOF':
      return
   else:
      raise "begin: Error!  Expecting digit or ("

def beginExpr( c ):
   a = getNext( c )
   if a == 'ADD':
      l = getExprList( c )
      return ['ADD'] + l
   elif a == 'SUB':
      l = getExprList( c )
      return ['SUB'] + l
   elif a == 'MUL':
      l = getExprList( c )
      return ['MUL'] + l
   elif a == 'DIV':
      l = getExprList( c )
      return ['DIV'] + l
   elif a == 'EOF':
      raise "beginExpr: Expression expected, got EOF!"
   else:
      raise "This should never happen!!!"
      

def getExprList( c ):
   l = []
   itm = peekNext( c )
   while itm != 'RPAREN':
      l.append( parseExpr( c ) )
      itm = peekNext( c )
   return l



a = '( + 10 ( - 20 30 40 ) )'
b = makeParsingContext( a )


# So, we have three states and eight terminal symbols
# *** means invalid, error
# 
#         ParseExpr    BeginExpr      ParseExprList  
# RPAREN  ***          ***            ret
# LPAREN  beginExpr    ***            parseList+parseExpr+ret
# ADD     ***          parseList+ret  parseList+parseExpr+ret
# SUB     ***          parseList+ret  parseList+parseExpr+ret
# DIV     ***          parseList+ret  parseList+parseExpr+ret
# MUL     ***          parseList+ret  parseList+parseExpr+ret
# EOF     end          ***            parseList+parseExpr+ret
# NUMBER  number       ***            parseList+parseExpr+ret
#
# A bit convoluted, but you get the idea.
# Starting from parseExpr we can either go to beginExpr, return a number,
# or hit EOF.
# From beginExpr we go to parseExprList, then return some data along with
# whatever it gives us.
# From ParseExprList we can either return the list we have, or go to parseExpr
# to get an item and recurse to keep building the list.
# ParseExprList is a bit weird, but you get the idea.
