# translates strings to phone-number sequences, eg 1-800-GET-CASH
# Simon Heath
# 16/07/2002

from string import upper, joinfields

# a module 'constant' dictionary
keypad = { 'abc':2, 'def':3,
  'ghi':4, 'jkl':5, 'mno':6,
  'prs':7, 'tuv':8, 'wxy':9 }

# a derived module constant dictionary
letmap = {}
for (letters, number) in keypad.items():
    for letter in letters:
        letmap[letter] = letmap[upper(letter)] = `number`

# translate one letter
def transletter(letter):
    try: return letmap[letter]
    except KeyError: # not the fastest way, but it illustrates `in'...
         if letter in '0123456789-()': return letter
         else: raise ValueError, 'no translation for: '+`letter`

def translate(string):
    return joinfields( map( transletter, string ), '' )


