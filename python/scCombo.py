#!/usr/bin/env python
#
# This is a crappy name, but anyhoo.  It's a proram/library to figure
# out ideal spell-overlaps for Spellcaster/Waving Hands.
# Look up the rules online if you don't understand; you will.
#
# Essentially a specialized form of string-matching...
#
# How we do it is this:
# There are level two, three, and four combos.  Level two is two spells
# chained, level three is three, etc.  Each combo has an overlap of one, two,
# etc.  This is how many gestures are shared by the various spells in it.
# We find a combo by taking two spells, or a spell and a combo, and seeing
# how much one overlaps on the other.  If the overlap is greater than 0,
# we remember it.
#
# Simon Heath
# 12/7/2005

# A spell or combo is a tuple of the form (name, gestures).  Both are strings.

SPELLS = [('Dispel Magic','CDPW'),
          ('Summon Elemental','CSWWS'),
          ('Magic Mirror','CW'),
          ('Lightning Bolt','DFFDD'),
          ('Cure Heavy','DFPW'),
          ('Cure Light','DFW'),
          ('Amnesia','DPP'),
          ('Confusion','DSF'),
          ('Disease','DSFFFC'),
          ('Blindness','DWFFD'),
          ('Delayed Effect','DWSSSP'),
          ('Raise Dead','DWWFWC'),
          ('Poison','DWWFWD'),
          ('Paralysis','FFF'),
          ('Summon Troll','FPSFW'),
          ('Fireball','FSSDD'),
          ('Remove Enchantment','PDWP'),
          ('Invisibility','PPWS'),
          ('Charm Monster','PSDD'),
          ('Charm Person','PSDF'),
          ('Summon Ogre','PSFW'),
          ('Finger of Death','PWPFSSSD'),
          ('Haste','PWPWWC'),
          ('Missile','SD'),
          ('Summon Goblin','SFW'),
          ('Antispell','SPF'),
          ('Permanency','SPFPSDW'),
          ('Time Stop','SPPC'),
          ('Resist Cold','SSFP'),
          ('Fear','SWD'),
          ('Fire Storm','SWWC'),
          ('Cause Light','WFP'),
          ('Cause Heavy','WPFD'),
          ('Counterspell','WPP'),
          ('Ice Storm','WSSC'),
          ('Resist Heat','WWFP'),
          ('Protection From Evil','WWP'),
          ('Counterspell','WWS'),
          ]


def getName( s ):
   sname, smoves = s
   return sname

def getMoves( s ):
   sname, smoves = s
   return smoves

def makeCombo( s1, s2 ):
   comboname = mergeNames( s1, s2 )
   combomoves = mergeMoves( s1, s2 )
   return (comboname, combomoves)

# This finds the overlap of two spells.
# So 'abcd' + 'cdii' -> 'abcdii', an overlap of 2
# a + b[2:] -> 'abcdii'
def findOverlap( s1, s2 ):
   s1moves = getMoves( s1 )
   s2moves = getMoves( s2 )
   overlap = getOverlapLevel( s1moves, s2moves )
   if overlap == len( s2moves ):
      return 0
   else:
      return overlap

def getOverlapLevel( s1, s2 ):
   for x in range( len( s1 ) ):
      if s1[-x:] == s2[:x]:
         return x
   return 0

def spellLength( spell ):
   return len( getMoves( spell ) )

# This actually merges the two given spells, overlapping them as much
# as possible.  It DOESN'T return a new spell, just a string of moves!
def mergeMoves( s1, s2 ):
   s1moves = getMoves( s1 )
   s2moves = getMoves( s2 )
   overlap = findOverlap( s1, s2 )
   return s1moves + s2moves[overlap:]

def mergeNames( s1, s2 ):
   s1name = getName( s1 )
   s2name = getName( s2 )
   return s1name + '-' + s2name

def findCombos( spells1, spells2 ):
   combos = []
   for x in spells1:
      for y in spells2:
         if x == y:
            continue
         combo = makeCombo( x, y )
         if spellLength( combo ) < (spellLength( x ) + spellLength( y ) - 1):
            combos.append( combo )
   for x in spells1:
      for y in spells2:
         if x == y:
            continue
         combo = makeCombo( y, x )
         if spellLength( combo ) < (spellLength( x ) + spellLength( y ) - 1):
            combos.append( combo )
   return combos

def cmpSpells( x, y ):
   s1 = getMoves( x )
   s2 = getMoves( y )
   return cmp( len( s1 ), len( s2 ) )

def runCombos():
   COMBOS2 = findCombos( SPELLS, SPELLS )
   COMBOS3 = findCombos( SPELLS, COMBOS2 )
   #COMBOS4 = findCombos( SPELLS, COMBOS3 )
   #COMBOS5 = findCombos( SPELLS, COMBOS4 )

   SPELLS.sort( cmpSpells )
   COMBOS2.sort( cmpSpells )
   COMBOS3.sort( cmpSpells )
   #COMBOS4.sort( cmpSpells )
   #COMBOS5.sort( cmpSpells )

   for x in COMBOS2:
      print x
   for x in COMBOS3:
      print x
   #for x in COMBOS4:
   #   print x
   #for x in COMBOS5:
   #   print x


if __name__ == '__main__':
   runCombos()
