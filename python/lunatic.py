# This is a kinda odd idea-test for a programming language,
# vaguely Forth-ish.
# The keys are: Interactive, bottom-up, compiled (later),
# possibly dynamically-typed (tagged), low-level...


import re




ERROR = -1
LPAREN = 0
RPAREN = 1
APPLY = 2
SET = 3


SYMBOL = 10

NUMBER = 20

NUMRE = re.compile( '[0-9]+' )
SYMRE = re.compile( '[a-zA-Z]+' )



class LexSymbol:
    def __init__( self, string ):
        self.value = None
        self.type = ERROR
        self.lex( string )

    def __repr__( self ):
        if self.type == ERROR:
            return "{INVALID SYMBOL}"
        elif self.type == LPAREN:
            return "{LPAREN}"
        elif self.type == RPAREN:
            return "{RPAREN}"
        elif self.type == APPLY:
            return "{APPLY}"
        elif self.type == SET:
            return "{SET}"
        
        elif self.type == SYMBOL:
            return "{SYMBOL: %s}" % self.value
        elif self.type == NUMBER:
            return "{NUMBER: %d}" % self.value
        else:
            return "UNKNOWN WOSSNAME!  SHIT!"
        

    def lex( self, string ):        
        if string == '(':
            self.type = LPAREN            
        elif string == ')':
            self.type = RPAREN
        elif string == '@':
            self.type = APPLY
        elif string == ':':
            self.type = SET
            
        else:
            intmatch = NUMRE.match( string )
            symmatch = SYMRE.match( string )
            if intmatch:
                self.type = NUMBER
                self.value = int( intmatch.group() )
            elif symmatch:
                self.type = SYMBOL
                self.value = symmatch.group()
            else:
                print "Well crap: '%s'" % string
                

    def getValue( self ):
        return self.value

    def getType( self ):
        return self.type

    def isType( self, t ):
        return self.type == t



def tokenize( string ):
    return string.split()

def lex( symlist ):
    return map( LexSymbol, symlist )


def readIn( string ):
    return lex( tokenize( string ) )


class SynAssign:
    def __init__( self, lhs, rhs ):
        self.lhs = lhs
        self.rhs = rhs



DICT = {}

def applyFunc( fname, args ):
    return
