#   python version of 99 bottles of beer, compact edition
#   by Fredrik Lundh (fredrik_lundh@ivab.se)

def bottle(n):
    try:
        return { 0: "no more bottles",
                 1: "1 bottle"} [n] + " of beer"
    except KeyError: return "%d bottles of beer" % n

for i in range(99, 0, -1):
    b1, b0 = bottle(i), bottle(i-1)
    print "%(b1)s on the wall, %(b1)s,\n"\
	  "take one down, pass it around,\n"\
	  "%(b0)s on the wall." % locals()

