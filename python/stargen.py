#!/usr/bin/python
# stargen.py
# UQM random starmap generator
# Yay!
#
# Simon Heath
# 13/10/2004

import random

# Okay.  So, first we have a star object.
class star:
   # X and Y positions of the star; 0 < xy < 10000
   x = 0
   y = 0
   # Can be DWARF_STAR, GIANT_STAR, or SUPER_GIANT_STAR
   type = "DWARF_STAR"
   color = "RED_BODY"
   # Can be a number between 0 and... 16?  0 means none.
   alienpresence = "0"
   # These are raw numbers that we can't do much about right now.
   prefixname = 0
   postfixname = 0

   def __init__( self, x, y, type, color, presence, prefix, postfix ):
      self.x = x
      self.y = y
      self.type = type
      self.color = color
      self.alienpresence = presence
      self.prefixname = prefix
      self.postfixname = postfix

   def prnt( self, stream ):
      print >> stream, \
            "   {{%d, %d}, MAKE_STAR( %s, %s, -1 ), %s, %d, %d}," % \
            (self.x, self.y, self.type, self.color, self.alienpresence, \
            self.prefixname, self.postfixname)

   def __cmp__( self, star ):
      if self.y < star.y:
         return -1
      elif self.y == star.y:
         return 0
      else:
         return 1


def randcolor():
   col = random.random()
   colstring = ""
   if col < 0.13:
      colstring = red
   elif col < 0.33:
      colstring = orange
   elif col < 0.5:
      colstring = yellow
   elif col < 0.66:
      colstring = green
   elif col < 0.83:
      colstring = blue
   else:
      colstring = white

   return colstring

def randsize():
   size = random.random()
   sizestring = ""
   if size < 0.87:
      sizestring = dwarf
   elif size < 0.99:
      sizestring = giant
   else:
      sizestring = sgiant

   return sizestring

def genstars():
   global STARLIST
   global CONSTSTARS
   STARLIST = CONSTSTARS
   for x in range( NUMSTARS - len( CONSTSTARS ) ):
      x = random.random() * 10000
      y = random.random() * 10000
      col = randcolor()
      size = randsize()
      prefix = random.random() * 6
      postfix = random.random() * 120
      
      STARLIST.append( star( x, y, size, col, 0, prefix, postfix ) )

   STARLIST.sort()


def main():
   #outstream = None
   outstream = open( "newplan.c", 'w' )

   print "Randomizing stars..."
   genstars()
   print "Done.  Writing star data..."
   numstars = len( STARLIST )
   print "Number of stars: %d" % numstars
   
   print >> outstream, PREFIXDAT
   for x in STARLIST:
      x.prnt( outstream )
   print >> outstream, POSTFIXDAT
   print "Done"
   
   
      


   


# Then we have all the constant data.  About 1450 lines of it.
NUMSTARS = 3000
STARLIST = []

dwarf = "DWARF_STAR"
giant = "GIANT_STAR"
sgiant = "SUPER_GIANT_STAR"
red = "RED_BODY"
orange = "ORANGE_BODY"
yellow = "YELLOW_BODY"
green = "GREEN_BODY"
blue = "BLUE_BODY"
white = "WHITE_BODY"

CONSTSTARS = [
star( 5007, 35, dwarf, green, "0", 6, 74 ),
star( 708, 41, dwarf, white, "0", 7, 91 ),
star( 4714, 78, dwarf, green, "0", 7, 74 ),
star( 2187, 83, dwarf, orange, "0", 0, 126 ),
star( 2814, 89, dwarf, orange, "0", 2, 82 ),
star( 4244, 91, dwarf, blue, "0", 0, 125 ),
star( 5652, 98, dwarf, white, "0", 0, 124 ),
star( 2939, 116, dwarf, orange, "0", 3, 82 ),
star( 2771, 146, dwarf, blue, "0", 1, 82 ),
star( 5313, 150, dwarf, white, "0", 6, 73 ),
star( 265, 156, dwarf, orange, "0", 5, 92 ),
star( 4529, 169, dwarf, blue, "0", 8, 74 ),
star( 4911, 180, giant, orange, "0", 1, 74 ),
star( 4747, 221, dwarf, orange, "0", 4, 74 ),
star( 9708, 250, dwarf, blue, "0", 0, 112 ),
star( 4861, 262, dwarf, white, "0", 2, 74 ),
star( 2908, 269, dwarf, blue, "SHOFIXTI_DEFINED", 4, 82 ),
star( 1855, 270, dwarf, green, "0", 5, 81 ),
star( 7958, 270, dwarf, blue, "0", 2, 8 ),
star( 5160, 280, dwarf, yellow, "0", 4, 73 ),
star( 570, 289, dwarf, green, "0", 4, 92 ),
star( 4923, 294, dwarf, yellow, "YEHAT_DEFINED", 3, 74 ),
star( 2820, 301, dwarf, green, "0", 5, 82 ),
star( 7934, 318, dwarf, blue, "0", 1, 8 ),
star( 8062, 318, dwarf, red, "0", 3, 8 ),
star( 1116, 334, dwarf, green, "0", 6, 91 ),
star( 803, 337, dwarf, yellow, "0", 3, 91 ),
star( 1787, 338, dwarf, green, "0", 6, 81 ),
star( 877, 340, dwarf, yellow, "0", 4, 91 ),
star( 5338, 355, dwarf, white, "0", 5, 73 ),
star( 5039, 373, dwarf, orange, "0", 1, 73 ),
star( 843, 380, giant, orange, "0", 1, 91 ),
star( 4872, 408, dwarf, red, "0", 5, 74 ),
star( 1740, 423, dwarf, blue, "0", 7, 81 ),
star( 4596, 429, dwarf, white, "0", 9, 74 ),
star( 843, 431, dwarf, yellow, "0", 2, 91 ),
star( 2156, 440, dwarf, orange, "0", 4, 81 ),
star( 2004, 441, dwarf, blue, "0", 1, 81 ),
star( 530, 442, dwarf, white, "0", 2, 92 ),
star( 958, 468, dwarf, blue, "0", 5, 91 ),
star( 2058, 475, dwarf, yellow, "0", 2, 81 ),
star( 304, 477, dwarf, yellow, "0", 1, 92 ),
star( 522, 525, dwarf, yellow, "PKUNK_DEFINED", 3, 92 ),
star( 2100, 554, dwarf, yellow, "0", 3, 81 ),
star( 134, 565, dwarf, green, "0", 6, 92 ),
star( 6858, 577, dwarf, green, "MYCON_DEFINED", 0, 123 ),
star( 5014, 584, dwarf, red, "0", 2, 73 ),
star( 5256, 608, dwarf, green, "0", 3, 73 ),
star( 2411, 718, dwarf, red, "0", 1, 9 ),
star( 2589, 741, dwarf, red, "0", 2, 9 ),
star( 675, 742, dwarf, orange, "0", 8, 91 ),
star( 9292, 750, dwarf, yellow, "0", 4, 5 ),
star( 1463, 779, giant, red, "0", 6, 80 ),
star( 3089, 782, dwarf, red, "0", 4, 9 ),
star( 2854, 787, dwarf, red, "0", 3, 9 ),
star( 3333, 801, dwarf, red, "0", 5, 9 ),
star( 9237, 821, dwarf, blue, "0", 5, 5 ),
star( 9339, 843, dwarf, white, "0", 1, 5 ),
star( 242, 857, giant, orange, "0", 3, 90 ),
star( 1515, 866, dwarf, green, "0", 5, 80 ),
star( 4770, 895, dwarf, blue, "0", 5, 75 ),
star( 1412, 905, dwarf, green, "0", 2, 80 ),
star( 4681, 916, dwarf, orange, "RAINBOW_DEFINED", 6, 75 ),
star( 9333, 937, sgiant, yellow, "MELNORME0_DEFINED", 2, 5 ),
star( 9419, 942, dwarf, blue, "0", 3, 5 ),
star( 230, 952, dwarf, yellow, "0", 2, 90 ),
star( 146, 955, dwarf, red, "0", 1, 90 ),
star( 4873, 968, dwarf, green, "0", 4, 75 ),
star( 1559, 993, sgiant, red, "MELNORME1_DEFINED", 1, 80 ),
star( 1895, 1041, dwarf, red, "0", 2, 93 ),
star( 4337, 1066, dwarf, blue, "0", 1, 75 ),
star( 3732, 1067, dwarf, green, "0", 0, 122 ),
star( 1579, 1115, dwarf, green, "0", 3, 80 ),
star( 4875, 1145, dwarf, orange, "0", 3, 75 ),
star( 4604, 1187, dwarf, orange, "0", 2, 75 ),
star( 5812, 1208, dwarf, orange, "0", 4, 72 ),
star( 1312, 1260, dwarf, yellow, "0", 4, 80 ),
star( 1916, 1270, dwarf, red, "0", 1, 93 ),
star( 6562, 1270, dwarf, orange, "0", 0, 121 ),
star( 416, 1301, dwarf, red, "0", 0, 120 ),
star( 3958, 1354, dwarf, blue, "0", 2, 89 ),
star( 4000, 1363, dwarf, orange, "0", 1, 89 ),
star( 1752, 1450, dwarf, yellow, "SOL_DEFINED", 0, 129 ),
star( 2187, 1500, dwarf, blue, "0", 0, 127 ),
star( 1806, 1507, giant, white, "0", 0, 128 ),
star( 5708, 1520, dwarf, orange, "0", 5, 72 ),
star( 9469, 1548, dwarf, green, "0", 2, 6 ),
star( 4333, 1562, dwarf, red, "0", 3, 88 ),
star( 6041, 1562, dwarf, blue, "0", 1, 72 ),
star( 9375, 1583, dwarf, green, "0", 1, 6 ),
star( 2881, 1614, dwarf, green, "0", 2, 96 ),
star( 6083, 1625, dwarf, green, "0", 3, 72 ),
star( 4250, 1645, dwarf, red, "0", 1, 88 ),
star( 650, 1646, dwarf, green, "0", 7, 85 ),
star( 9477, 1670, dwarf, yellow, "0", 3, 6 ),
star( 2840, 1676, dwarf, green, "0", 1, 96 ),
star( 9541, 1687, giant, red, "0", 4, 6 ),
star( 7395, 1687, dwarf, yellow, "0", 3, 69 ),
star( 4333, 1687, dwarf, orange, "VUX_DEFINED", 2, 88 ),
star( 9559, 1735, dwarf, orange, "0", 5, 6 ),
star( 736, 1737, giant, blue, "0", 6, 85 ),
star( 1601, 1746, dwarf, red, "0", 1, 94 ),
star( 7395, 1750, dwarf, blue, "0", 1, 69 ),
star( 951, 1770, dwarf, yellow, "0", 1, 85 ),
star( 1666, 1812, dwarf, yellow, "0", 2, 94 ),
star( 7187, 1833, dwarf, yellow, "0", 2, 69 ),
star( 705, 1838, dwarf, green, "0", 5, 85 ),
star( 1140, 1847, dwarf, white, "0", 2, 85 ),
star( 6467, 1878, dwarf, blue, "0", 1, 71 ),
star( 2791, 1895, dwarf, red, "0", 3, 96 ),
star( 6500, 1916, dwarf, white, "0", 2, 71 ),
star( 5458, 1916, dwarf, yellow, "0", 0, 119 ),
star( 1048, 1919, dwarf, green, "0", 3, 85 ),
star( 3678, 1926, dwarf, blue, "0", 2, 99 ),
star( 3345, 1931, dwarf, yellow, "START_COLONY_DEFINED", 0, 98 ),
star( 8187, 1937, dwarf, white, "0", 4, 7 ),
star( 3352, 1940, sgiant, white, "MELNORME2_DEFINED", 0, 97 ),
star( 977, 1953, dwarf, yellow, "0", 4, 85 ),
star( 4221, 1986, dwarf, blue, "MAIDENS_DEFINED", 1, 100 ),
star( 4500, 2000, dwarf, orange, "0", 2, 100 ),
star( 6833, 2000, dwarf, blue, "0", 1, 70 ),
star( 8163, 2009, dwarf, white, "0", 3, 7 ),
star( 8080, 2011, dwarf, orange, "0", 2, 7 ),
star( 6036, 2035, dwarf, blue, "0", 4, 71 ),
star( 6479, 2062, dwarf, green, "EGG_CASE1_DEFINED", 3, 71 ),
star( 2104, 2083, dwarf, orange, "ZOQ_SCOUT_DEFINED", 0, 118 ),
star( 8062, 2083, dwarf, white, "0", 1, 7 ),
star( 270, 2187, dwarf, blue, "0", 1, 79 ),
star( 6500, 2208, dwarf, blue, "0", 6, 71 ),
star( 6291, 2208, dwarf, green, "MYCON_DEFINED", 5, 71 ),
star( 125, 2229, dwarf, blue, "0", 2, 79 ),
star( 312, 2250, dwarf, blue, "0", 3, 79 ),
star( 3884, 2262, dwarf, yellow, "0", 3, 99 ),
star( 742, 2268, dwarf, orange, "CHMMR_DEFINED", 0, 117 ),
star( 2306, 2285, dwarf, orange, "0", 1, 95 ),
star( 2402, 2309, dwarf, red, "0", 2, 95 ),
star( 6395, 2312, dwarf, green, "SUN_DEVICE_DEFINED", 2, 12 ),
star( 8875, 2312, dwarf, green, "0", 9, 61 ),
star( 3551, 2320, dwarf, red, "0", 1, 99 ),
star( 6208, 2333, dwarf, orange, "0", 1, 12 ),
star( 3354, 2354, dwarf, orange, "0", 4, 99 ),
star( 9909, 2359, dwarf, blue, "0", 0, 111 ),
star( 2298, 2385, dwarf, red, "0", 3, 95 ),
star( 7020, 2395, dwarf, yellow, "0", 2, 70 ),
star( 9038, 2407, dwarf, red, "0", 5, 61 ),
star( 9375, 2416, dwarf, green, "0", 8, 61 ),
star( 6500, 2458, dwarf, red, "0", 6, 12 ),
star( 217, 2509, dwarf, orange, "0", 4, 78 ),
star( 3641, 2512, dwarf, green, "0", 2, 86 ),
star( 5625, 2520, dwarf, red, "0", 3, 14 ),
star( 3713, 2537, dwarf, green, "ORZ_DEFINED", 3, 86 ),
star( 3587, 2566, dwarf, green, "ANDROSYNTH_DEFINED", 7, 86 ),
star( 9291, 2583, dwarf, blue, "0", 1, 61 ),
star( 3654, 2587, sgiant, green, "MELNORME3_DEFINED", 1, 86 ),
star( 3721, 2619, dwarf, green, "TAALO_PROTECTOR_DEFINED", 4, 86 ),
star( 5791, 2625, dwarf, green, "0", 1, 14 ),
star( 6416, 2625, dwarf, orange, "0", 5, 12 ),
star( 6008, 2631, dwarf, yellow, "EGG_CASE0_DEFINED", 2, 14 ),
star( 3608, 2637, dwarf, green, "0", 6, 86 ),
star( 3499, 2648, dwarf, blue, "0", 1, 87 ),
star( 9479, 2666, dwarf, white, "0", 2, 61 ),
star( 3668, 2666, dwarf, green, "0", 5, 86 ),
star( 229, 2666, dwarf, green, "0", 1, 78 ),
star( 8895, 2687, dwarf, orange, "0", 7, 61 ),
star( 138, 2696, dwarf, red, "0", 5, 78 ),
star( 5375, 2729, dwarf, blue, "0", 0, 116 ),
star( 6354, 2729, dwarf, white, "EGG_CASE2_DEFINED", 3, 12 ),
star( 6458, 2750, dwarf, green, "0", 4, 12 ),
star( 2458, 2750, dwarf, green, "0", 6, 106 ),
star( 351, 2758, dwarf, yellow, "0", 2, 78 ),
star( 7083, 2770, dwarf, red, "0", 3, 70 ),
star( 3759, 2778, dwarf, orange, "0", 4, 87 ),
star( 9333, 2791, dwarf, red, "0", 3, 61 ),
star( 3400, 2804, dwarf, white, "0", 2, 87 ),
star( 9469, 2806, dwarf, orange, "DRUUGE_DEFINED", 6, 61 ),
star( 3619, 2830, dwarf, orange, "0", 3, 87 ),
star( 2208, 2854, dwarf, orange, "0", 7, 106 ),
star( 9250, 2854, dwarf, white, "0", 4, 61 ),
star( 672, 2863, dwarf, orange, "0", 7, 78 ),
star( 167, 2875, dwarf, red, "0", 6, 78 ),
star( 4030, 2887, dwarf, red, "0", 2, 105 ),
star( 384, 2900, dwarf, orange, "0", 3, 78 ),
star( 2727, 2951, dwarf, green, "0", 5, 106 ),
star( 4645, 2958, dwarf, red, "0", 3, 105 ),
star( 5625, 2958, dwarf, blue, "0", 2, 13 ),
star( 8270, 2958, dwarf, green, "0", 3, 66 ),
star( 8291, 2979, dwarf, orange, "0", 2, 66 ),
star( 6020, 2979, dwarf, orange, "RAINBOW_DEFINED", 3, 13 ),
star( 6562, 3020, dwarf, blue, "0", 4, 70 ),
star( 2011, 3043, dwarf, orange, "0", 8, 106 ),
star( 8125, 3083, dwarf, orange, "0", 1, 66 ),
star( 2354, 3166, giant, yellow, "0", 4, 106 ),
star( 3833, 3187, dwarf, red, "0", 1, 105 ),
star( 5812, 3208, dwarf, yellow, "0", 1, 13 ),
star( 9000, 3250, dwarf, red, "0", 0, 113 ),
star( 291, 3250, dwarf, green, "0", 1, 84 ),
star( 501, 3259, dwarf, green, "0", 2, 84 ),
star( 791, 3270, dwarf, red, "0", 3, 84 ),
star( 2354, 3291, sgiant, red, "MELNORME4_DEFINED", 1, 106 ),
star( 1104, 3333, dwarf, white, "0", 4, 84 ),
star( 2687, 3333, dwarf, blue, "0", 3, 106 ),
star( 3187, 3375, dwarf, blue, "0", 2, 107 ),
star( 1758, 3418, dwarf, blue, "0", 2, 108 ),
star( 2520, 3437, dwarf, orange, "0", 2, 106 ),
star( 8437, 3458, dwarf, green, "0", 1, 64 ),
star( 8770, 3458, dwarf, green, "0", 4, 64 ),
star( 3000, 3500, dwarf, blue, "0", 1, 107 ),
star( 149, 3519, dwarf, red, "0", 5, 76 ),
star( 8791, 3541, dwarf, orange, "0", 2, 64 ),
star( 2148, 3551, dwarf, white, "0", 2, 109 ),
star( 7375, 3562, dwarf, blue, "0", 0, 115 ),
star( 9312, 3562, dwarf, blue, "0", 2, 63 ),
star( 9599, 3583, dwarf, green, "0", 4, 63 ),
star( 9375, 3604, dwarf, yellow, "0", 3, 63 ),
star( 90, 3614, dwarf, blue, "0", 6, 76 ),
star( 2770, 3625, dwarf, red, "0", 4, 107 ),
star( 8708, 3625, dwarf, orange, "0", 3, 64 ),
star( 267, 3645, dwarf, blue, "0", 3, 76 ),
star( 1604, 3645, dwarf, white, "0", 1, 108 ),
star( 2274, 3663, dwarf, white, "0", 1, 109 ),
star( 229, 3666, dwarf, green, "ILWRATH_DEFINED", 1, 76 ),
star( 3083, 3674, dwarf, red, "0", 3, 107 ),
star( 2416, 3687, giant, orange, "SPATHI_DEFINED", 5, 109 ),
star( 9333, 3708, dwarf, green, "0", 1, 63 ),
star( 2250, 3708, dwarf, white, "0", 3, 109 ),
star( 288, 3735, dwarf, white, "0", 2, 76 ),
star( 2354, 3741, dwarf, red, "0", 4, 109 ),
star( 2583, 3750, dwarf, white, "0", 6, 109 ),
star( 4125, 3770, dwarf, blue, "SYREEN_DEFINED", 0, 114 ),
star( 166, 3770, dwarf, white, "0", 4, 76 ),
star( 6270, 3833, dwarf, green, "0", 4, 10 ),
star( 2145, 3916, dwarf, green, "0", 1, 110 ),
star( 6125, 3937, dwarf, green, "0", 3, 10 ),
star( 6291, 3937, dwarf, red, "0", 9, 10 ),
star( 5937, 3937, dwarf, orange, "SHIP_VAULT_DEFINED", 5, 10 ),
star( 2479, 3958, dwarf, orange, "0", 7, 109 ),
star( 926, 3972, dwarf, red, "0", 2, 83 ),
star( 2062, 3991, dwarf, orange, "0", 2, 110 ),
star( 5895, 4020, dwarf, red, "0", 8, 10 ),
star( 285, 4020, dwarf, white, "0", 1, 77 ),
star( 6062, 4041, giant, yellow, "0", 1, 10 ),
star( 2875, 4041, dwarf, blue, "0", 2, 20 ),
star( 8645, 4062, dwarf, red, "0", 2, 65 ),
star( 860, 4065, dwarf, blue, "0", 1, 83 ),
star( 5958, 4083, dwarf, green, "0", 2, 10 ),
star( 3038, 4083, dwarf, blue, "0", 3, 20 ),
star( 291, 4104, dwarf, orange, "0", 2, 77 ),
star( 6166, 4125, dwarf, orange, "0", 6, 10 ),
star( 9812, 4145, dwarf, blue, "0", 3, 62 ),
star( 8520, 4166, dwarf, red, "0", 1, 65 ),
star( 9573, 4182, dwarf, red, "0", 2, 62 ),
star( 500, 4187, dwarf, blue, "0", 3, 77 ),
star( 2145, 4208, dwarf, red, "0", 3, 110 ),
star( 6208, 4229, dwarf, orange, "0", 7, 10 ),
star( 2812, 4250, dwarf, orange, "0", 7, 20 ),
star( 2937, 4306, dwarf, blue, "0", 4, 20 ),
star( 9416, 4395, dwarf, blue, "0", 1, 62 ),
star( 2875, 4479, giant, white, "0", 1, 20 ),
star( 250, 4583, dwarf, red, "0", 5, 26 ),
star( 7250, 4583, dwarf, green, "0", 4, 68 ),
star( 479, 4583, dwarf, blue, "0", 1, 26 ),
star( 5708, 4604, dwarf, red, "0", 0, 104 ),
star( 479, 4645, dwarf, green, "0", 2, 26 ),
star( 2895, 4687, dwarf, green, "0", 6, 20 ),
star( 2708, 4708, dwarf, blue, "0", 5, 20 ),
star( 562, 4708, dwarf, green, "0", 3, 26 ),
star( 416, 4717, dwarf, red, "0", 4, 26 ),
star( 5094, 4931, dwarf, red, "0", 4, 11 ),
star( 9000, 5000, dwarf, red, "0", 2, 67 ),
star( 8958, 5000, giant, blue, "0", 1, 67 ),
star( 5006, 5011, dwarf, orange, "0", 3, 11 ),
star( 7312, 5062, dwarf, orange, "0", 1, 68 ),
star( 3679, 5068, dwarf, yellow, "0", 3, 17 ),
star( 9062, 5083, dwarf, orange, "0", 3, 67 ),
star( 7416, 5083, dwarf, green, "RAINBOW_DEFINED", 3, 68 ),
star( 5155, 5122, dwarf, green, "0", 2, 11 ),
star( 3875, 5145, dwarf, yellow, "0", 4, 17 ),
star( 4937, 5145, dwarf, green, "0", 1, 11 ),
star( 2979, 5166, giant, orange, "0", 1, 15 ),
star( 3035, 5178, dwarf, orange, "0", 2, 15 ),
star( 3994, 5185, dwarf, red, "0", 5, 17 ),
star( 3541, 5187, dwarf, blue, "0", 1, 17 ),
star( 5977, 5246, dwarf, green, "0", 1, 102 ),
star( 3770, 5250, dwarf, green, "0", 2, 17 ),
star( 1520, 5261, dwarf, red, "0", 3, 55 ),
star( 1613, 5279, dwarf, green, "0", 4, 55 ),
star( 7020, 5291, dwarf, blue, "0", 2, 68 ),
star( 1416, 5315, dwarf, white, "0", 2, 55 ),
star( 2993, 5318, dwarf, red, "0", 3, 15 ),
star( 1425, 5404, dwarf, blue, "0", 1, 55 ),
star( 1854, 5416, dwarf, white, "0", 5, 55 ),
star( 3625, 5437, giant, green, "0", 1, 16 ),
star( 3416, 5437, dwarf, blue, "0", 2, 16 ),
star( 4000, 5437, dwarf, green, "ZOQFOT_DEFINED", 1, 18 ),
star( 6270, 5479, dwarf, red, "0", 2, 102 ),
star( 3583, 5479, dwarf, green, "0", 3, 16 ),
star( 4083, 5513, dwarf, red, "0", 3, 18 ),
star( 2159, 5614, dwarf, orange, "0", 6, 55 ),
star( 3937, 5625, dwarf, orange, "0", 2, 18 ),
star( 6014, 5632, giant, blue, "0", 1, 21 ),
star( 250, 5687, dwarf, green, "0", 1, 25 ),
star( 3625, 5750, giant, red, "0", 2, 19 ),
star( 371, 5772, dwarf, red, "0", 2, 25 ),
star( 6107, 5785, dwarf, yellow, "0", 2, 21 ),
star( 9645, 5791, dwarf, orange, "BURVIXESE_DEFINED", 0, 130 ),
star( 1545, 5818, dwarf, orange, "0", 5, 54 ),
star( 3750, 5833, giant, green, "0", 1, 19 ),
star( 6301, 5875, dwarf, yellow, "0", 5, 21 ),
star( 1923, 5878, dwarf, orange, "0", 3, 54 ),
star( 4625, 5895, dwarf, green, "0", 2, 131 ),
star( 152, 5900, dwarf, red, "0", 3, 25 ),
star( 5437, 5916, dwarf, yellow, "0", 4, 33 ),
star( 1714, 5926, dwarf, yellow, "0", 4, 54 ),
star( 6200, 5935, dwarf, yellow, "SAMATRA_DEFINED", 4, 21 ),
star( 6429, 5958, dwarf, red, "0", 7, 21 ),
star( 4729, 5958, dwarf, orange, "0", 4, 131 ),
star( 1978, 5968, dwarf, green, "TALKING_PET_DEFINED", 2, 54 ),
star( 395, 5979, giant, green, "0", 1, 22 ),
star( 563, 5980, dwarf, orange, "0", 5, 22 ),
star( 456, 5989, dwarf, orange, "0", 6, 22 ),
star( 4625, 6000, dwarf, blue, "0", 1, 131 ),
star( 6166, 6000, dwarf, white, "0", 3, 21 ),
star( 6496, 6032, dwarf, orange, "0", 6, 21 ),
star( 2228, 6038, dwarf, blue, "0", 12, 54 ),
star( 4583, 6041, dwarf, orange, "0", 3, 131 ),
star( 1558, 6058, dwarf, yellow, "0", 6, 54 ),
star( 1902, 6065, dwarf, green, "0", 1, 54 ),
star( 2159, 6073, dwarf, yellow, "0", 11, 54 ),
star( 365, 6093, dwarf, blue, "0", 2, 22 ),
star( 541, 6145, dwarf, orange, "0", 4, 22 ),
star( 2200, 6176, dwarf, blue, "0", 10, 54 ),
star( 729, 6208, dwarf, green, "0", 3, 23 ),
star( 5250, 6229, dwarf, yellow, "0", 3, 33 ),
star( 8166, 6250, dwarf, red, "0", 3, 40 ),
star( 6215, 6255, dwarf, red, "0", 8, 21 ),
star( 437, 6270, dwarf, blue, "0", 3, 22 ),
star( 5583, 6291, dwarf, white, "0", 1, 33 ),
star( 1881, 6308, dwarf, green, "0", 8, 54 ),
star( 1795, 6329, dwarf, yellow, "0", 7, 54 ),
star( 2118, 6379, dwarf, blue, "0", 9, 54 ),
star( 750, 6458, giant, white, "0", 1, 23 ),
star( 3716, 6458, dwarf, red, "0", 1, 30 ),
star( 1360, 6489, dwarf, green, "0", 2, 56 ),
star( 7333, 6500, dwarf, white, "0", 1, 40 ),
star( 3770, 6500, dwarf, green, "0", 2, 30 ),
star( 4500, 6500, dwarf, blue, "0", 0, 37 ),
star( 187, 6520, dwarf, orange, "0", 4, 24 ),
star( 125, 6541, giant, red, "0", 1, 24 ),
star( 7812, 6562, dwarf, orange, "0", 2, 40 ),
star( 770, 6602, dwarf, red, "0", 2, 23 ),
star( 5910, 6624, dwarf, blue, "0", 1, 29 ),
star( 208, 6625, dwarf, green, "0", 3, 24 ),
star( 2604, 6645, dwarf, red, "0", 1, 101 ),
star( 1578, 6668, sgiant, green, "MELNORME5_DEFINED", 1, 56 ),
star( 5479, 6687, dwarf, green, "0", 2, 33 ),
star( 375, 6716, dwarf, white, "0", 2, 24 ),
star( 312, 6728, dwarf, orange, "0", 5, 24 ),
star( 6020, 6729, dwarf, blue, "0", 2, 29 ),
star( 5062, 6750, dwarf, blue, "0", 10, 28 ),
star( 4208, 6854, dwarf, orange, "0", 1, 31 ),
star( 5145, 6875, dwarf, green, "0", 9, 28 ),
star( 4291, 6937, dwarf, orange, "0", 2, 31 ),
star( 5145, 6958, dwarf, blue, "0", 8, 28 ),
star( 7208, 7000, dwarf, red, "0", 3, 39 ),
star( 8625, 7000, dwarf, green, "RAINBOW_DEFINED", 1, 41 ),
star( 4955, 7034, dwarf, orange, "0", 2, 28 ),
star( 4895, 7041, dwarf, green, "0", 3, 28 ),
star( 4971, 7104, dwarf, white, "0", 1, 28 ),
star( 8666, 7104, dwarf, green, "0", 2, 41 ),
star( 4854, 7125, dwarf, orange, "0", 4, 28 ),
star( 5083, 7145, dwarf, blue, "0", 7, 28 ),
star( 7360, 7184, dwarf, red, "0", 4, 39 ),
star( 1020, 7187, dwarf, red, "0", 3, 58 ),
star( 3875, 7187, dwarf, orange, "0", 1, 32 ),
star( 4879, 7201, dwarf, yellow, "0", 5, 28 ),
star( 4958, 7229, dwarf, green, "0", 6, 28 ),
star( 7125, 7250, dwarf, red, "0", 2, 39 ),
star( 7532, 7258, dwarf, red, "0", 5, 39 ),
star( 2416, 7291, dwarf, red, "0", 2, 101 ),
star( 3854, 7291, dwarf, green, "0", 2, 32 ),
star( 9687, 7333, dwarf, white, "0", 3, 44 ),
star( 395, 7458, dwarf, blue, "RAINBOW_DEFINED", 2, 60 ),
star( 4895, 7458, dwarf, orange, "0", 3, 36 ),
star( 4645, 7479, dwarf, red, "0", 4, 36 ),
star( 6940, 7514, dwarf, red, "0", 11, 39 ),
star( 7443, 7538, dwarf, red, "0", 6, 39 ),
star( 6479, 7541, dwarf, orange, "0", 0, 38 ),
star( 7208, 7541, dwarf, yellow, "0", 1, 39 ),
star( 5791, 7583, dwarf, white, "0", 3, 34 ),
star( 333, 7625, dwarf, blue, "0", 1, 60 ),
star( 5958, 7645, dwarf, white, "0", 2, 34 ),
star( 1041, 7708, dwarf, orange, "0", 2, 58 ),
star( 5875, 7729, sgiant, yellow, "MELNORME6_DEFINED", 1, 34 ),
star( 1125, 7791, giant, blue, "0", 1, 58 ),
star( 4979, 7791, dwarf, white, "0", 2, 36 ),
star( 4958, 7791, giant, white, "0", 1, 36 ),
star( 6889, 7803, dwarf, red, "0", 10, 39 ),
star( 7200, 7849, dwarf, red, "0", 8, 39 ),
star( 7395, 7854, dwarf, red, "0", 7, 39 ),
star( 9437, 7854, dwarf, red, "0", 2, 44 ),
star( 2836, 7857, dwarf, white, "RAINBOW_DEFINED", 5, 53 ),
star( 5375, 7875, dwarf, white, "0", 1, 35 ),
star( 6187, 7875, dwarf, red, "0", 7, 35 ),
star( 6041, 7916, dwarf, orange, "0", 5, 35 ),
star( 5979, 7979, dwarf, green, "0", 4, 35 ),
star( 7083, 7993, dwarf, red, "0", 9, 39 ),
star( 3270, 8000, dwarf, yellow, "0", 8, 53 ),
star( 6104, 8000, dwarf, orange, "0", 6, 35 ),
star( 687, 8000, dwarf, orange, "0", 2, 59 ),
star( 562, 8000, giant, green, "URQUAN_WRECK_DEFINED", 1, 59 ),
star( 5645, 8020, dwarf, blue, "0", 2, 35 ),
star( 1395, 8041, dwarf, red, "0", 4, 58 ),
star( 8229, 8041, dwarf, red, "0", 2, 43 ),
star( 2518, 8056, dwarf, white, "0", 3, 53 ),
star( 5875, 8062, dwarf, blue, "0", 3, 35 ),
star( 8416, 8083, dwarf, blue, "0", 1, 43 ),
star( 9000, 8229, dwarf, green, "0", 1, 44 ),
star( 3562, 8250, dwarf, yellow, "0", 9, 53 ),
star( 5437, 8270, dwarf, red, "RAINBOW_DEFINED", 5, 48 ),
star( 1520, 8333, dwarf, orange, "0", 5, 58 ),
star( 2771, 8351, dwarf, blue, "0", 1, 53 ),
star( 2535, 8358, dwarf, yellow, "THRADD_DEFINED", 4, 53 ),
star( 3151, 8390, dwarf, red, "0", 7, 53 ),
star( 2362, 8395, dwarf, green, "0", 11, 53 ),
star( 2822, 8395, dwarf, red, "0", 2, 53 ),
star( 5500, 8395, dwarf, orange, "0", 2, 48 ),
star( 2536, 8504, dwarf, green, "0", 4, 2 ),
star( 2582, 8507, sgiant, yellow, "MELNORME7_DEFINED", 1, 2 ),
star( 8625, 8562, dwarf, orange, "0", 6, 3 ),
star( 4375, 8562, dwarf, red, "0", 0, 50 ),
star( 2593, 8569, dwarf, red, "0", 2, 2 ),
star( 2562, 8572, dwarf, orange, "0", 3, 2 ),
star( 8492, 8578, dwarf, white, "0", 7, 3 ),
star( 1125, 8583, dwarf, orange, "0", 6, 58 ),
star( 8073, 8588, dwarf, orange, "0", 1, 46 ),
star( 8560, 8638, dwarf, green, "0", 1, 3 ),
star( 8750, 8645, dwarf, blue, "0", 5, 3 ),
star( 5562, 8645, dwarf, green, "0", 1, 48 ),
star( 2588, 8653, dwarf, red, "0", 14, 53 ),
star( 2458, 8666, dwarf, white, "0", 10, 53 ),
star( 7666, 8666, dwarf, orange, "RAINBOW_DEFINED", 2, 46 ),
star( 2776, 8673, dwarf, orange, "AQUA_HELIX_DEFINED", 6, 53 ),
star( 8630, 8693, dwarf, green, "UTWIG_DEFINED", 2, 3 ),
star( 2310, 8702, dwarf, red, "0", 12, 53 ),
star( 437, 8770, dwarf, red, "0", 1, 57 ),
star( 8534, 8797, dwarf, orange, "RAINBOW_DEFINED", 3, 3 ),
star( 8588, 8812, dwarf, blue, "0", 4, 3 ),
star( 7187, 8812, dwarf, blue, "0", 3, 46 ),
star( 5475, 8823, dwarf, orange, "0", 3, 48 ),
star( 3050, 8833, dwarf, blue, "0", 4, 1 ),
star( 2831, 8854, dwarf, green, "0", 3, 1 ),
star( 2300, 8861, dwarf, red, "0", 13, 53 ),
star( 479, 8875, dwarf, red, "0", 2, 57 ),
star( 2706, 8910, dwarf, yellow, "0", 2, 1 ),
star( 333, 8916, dwarf, green, "0", 3, 57 ),
star( 2535, 8917, dwarf, white, "0", 5, 1 ),
star( 8322, 8934, dwarf, white, "0", 1, 45 ),
star( 8249, 8958, dwarf, orange, "0", 4, 45 ),
star( 8375, 8958, dwarf, blue, "0", 2, 45 ),
star( 5645, 8979, dwarf, red, "0", 4, 48 ),
star( 2687, 9000, dwarf, blue, "0", 1, 1 ),
star( 8375, 9041, dwarf, orange, "0", 3, 45 ),
star( 9960, 9042, giant, white, "RAINBOW_DEFINED", 0, 42 ),
star( 7354, 9062, dwarf, blue, "0", 1, 47 ),
star( 7833, 9083, dwarf, white, "0", 6, 47 ),
star( 2581, 9105, dwarf, red, "0", 6, 1 ),
star( 7545, 9107, dwarf, orange, "0", 3, 47 ),
star( 7414, 9124, dwarf, green, "SUPOX_DEFINED", 2, 47 ),
star( 8500, 9125, dwarf, orange, "0", 5, 45 ),
star( 104, 9125, dwarf, red, "0", 5, 27 ),
star( 7889, 9181, dwarf, green, "0", 7, 47 ),
star( 7791, 9187, dwarf, orange, "0", 4, 47 ),
star( 7791, 9229, dwarf, white, "0", 5, 47 ),
star( 4812, 9270, dwarf, orange, "0", 0, 51 ),
star( 8500, 9372, dwarf, yellow, "BOMB_DEFINED", 6, 45 ),
star( 7255, 9374, dwarf, green, "0", 11, 45 ),
star( 8458, 9393, dwarf, yellow, "0", 7, 45 ),
star( 1000, 9395, dwarf, orange, "0", 4, 27 ),
star( 5711, 9475, dwarf, orange, "0", 2, 49 ),
star( 62, 9479, dwarf, green, "0", 3, 27 ),
star( 5989, 9496, dwarf, orange, "0", 7, 49 ),
star( 8000, 9505, dwarf, white, "0", 9, 45 ),
star( 5329, 9538, dwarf, yellow, "0", 5, 49 ),
star( 2916, 9541, dwarf, red, "0", 2, 103 ),
star( 8296, 9548, dwarf, green, "0", 8, 45 ),
star( 5600, 9552, dwarf, orange, "0", 1, 49 ),
star( 7664, 9589, dwarf, green, "0", 10, 45 ),
star( 6125, 9604, dwarf, red, "0", 8, 49 ),
star( 9144, 9686, dwarf, yellow, "0", 4, 4 ),
star( 5781, 9711, dwarf, yellow, "0", 3, 49 ),
star( 5229, 9729, dwarf, red, "0", 6, 49 ),
star( 9120, 9741, dwarf, red, "0", 3, 4 ),
star( 9186, 9741, dwarf, red, "0", 2, 4 ),
star( 9159, 9745, sgiant, blue, "MELNORME8_DEFINED", 1, 4 ),
star( 333, 9750, dwarf, red, "0", 0, 0 ),
star( 9147, 9790, dwarf, orange, "0", 5, 4 ),
star( 5704, 9795, dwarf, yellow, "VUX_BEAST_DEFINED", 4, 49 ),
star( 333, 9812, dwarf, green, "SLYLANDRO_DEFINED", 2, 27 ),
star( 1020, 9937, dwarf, red, "0", 7, 27 ),
star( 83, 9979, dwarf, red, "0", 6, 27 ),
star( 1937, 9979, dwarf, red, "0", 1, 103 ),
star( 4395, 9979, dwarf, green, "0", 0, 52 ),
   ]

PREFIXDAT = """

#include "starcon.h"
#include "planets/elemdata.h"

STAR_DESC starmap_array[] =
{
"""

POSTFIXDAT = """
	{{MAX_X_UNIVERSE << 1, MAX_Y_UNIVERSE << 1}, 0, 0, 0, 0},

	// QuasiSpace locations
#define VORTEX_SCALE 20
	{{(-12* VORTEX_SCALE) + 5000, (-21 * VORTEX_SCALE) + 5000},
			MAKE_STAR (DWARF_STAR, WHITE_BODY, -1), 0, 0, 132},
	{{( 1 * VORTEX_SCALE) + 5000, (-20 * VORTEX_SCALE) + 5000},
			MAKE_STAR (DWARF_STAR, WHITE_BODY, -1), 0, 0, 132},
	{{(-16 * VORTEX_SCALE) + 5000, (-18 * VORTEX_SCALE) + 5000},
			MAKE_STAR (DWARF_STAR, WHITE_BODY, -1), 0, 0, 132},
	{{( 8 * VORTEX_SCALE) + 5000, (-17 * VORTEX_SCALE) + 5000},
			MAKE_STAR (DWARF_STAR, WHITE_BODY, -1), 0, 0, 132},
	{{( 3 * VORTEX_SCALE) + 5000, (-13 * VORTEX_SCALE) + 5000},
			MAKE_STAR (DWARF_STAR, WHITE_BODY, -1), 0, 0, 132},
	{{(-21 * VORTEX_SCALE) + 5000, (-4 * VORTEX_SCALE) + 5000},
			MAKE_STAR (DWARF_STAR, WHITE_BODY, -1), 0, 0, 132},
	{{(-4 * VORTEX_SCALE) + 5000, (-4 * VORTEX_SCALE) + 5000},
			MAKE_STAR (DWARF_STAR, WHITE_BODY, -1), 0, 0, 132},
	{{(-12 * VORTEX_SCALE) + 5000, (-2 * VORTEX_SCALE) + 5000},
			MAKE_STAR (DWARF_STAR, WHITE_BODY, -1), 0, 0, 132},
	{{(-26 * VORTEX_SCALE) + 5000, (2 * VORTEX_SCALE) + 5000},
			MAKE_STAR (DWARF_STAR, WHITE_BODY, -1), 0, 0, 132},
	{{(-17 * VORTEX_SCALE) + 5000, (7 * VORTEX_SCALE) + 5000},
			MAKE_STAR (DWARF_STAR, WHITE_BODY, -1), 0, 0, 132},
	{{(10 * VORTEX_SCALE) + 5000, (7 * VORTEX_SCALE) + 5000},
			MAKE_STAR (DWARF_STAR, WHITE_BODY, -1), 0, 0, 132},
	{{(15 * VORTEX_SCALE) + 5000, (14 * VORTEX_SCALE) + 5000},
			MAKE_STAR (DWARF_STAR, WHITE_BODY, -1), 0, 0, 132},
	{{(22 * VORTEX_SCALE) + 5000, (16 * VORTEX_SCALE) + 5000},
			MAKE_STAR (DWARF_STAR, WHITE_BODY, -1), 0, 0, 132},
	{{(-6 * VORTEX_SCALE) + 5000, (19 * VORTEX_SCALE) + 5000},
			MAKE_STAR (DWARF_STAR, WHITE_BODY, -1), 0, 0, 132},
	{{(10 * VORTEX_SCALE) + 5000, (20 * VORTEX_SCALE) + 5000},
			MAKE_STAR (DWARF_STAR, WHITE_BODY, -1), 0, 0, 132},
	{{(9 * VORTEX_SCALE) + 5000, (18 * VORTEX_SCALE) + 5000},
			MAKE_STAR (DWARF_STAR, WHITE_BODY, -1), 0, 0, 132},

	{{6134, 5900}, MAKE_STAR (DWARF_STAR, YELLOW_BODY, -1), 0, 0, 132},

	{{MAX_X_UNIVERSE << 1, MAX_Y_UNIVERSE << 1}, 0, 0, 0, 0},
};

const BYTE element_array[NUMBER_OF_ELEMENTS] =
{
	COMMON, /* HYDROGEN */
	COMMON, /* HELIUM */
	COMMON, /* LITHIUM */
	BASE_METAL, /* BERYLLIUM */
	BASE_METAL, /* BORON */
	COMMON, /* CARBON */
	COMMON, /* NITROGEN */
	CORROSIVE, /* OXYGEN */
	CORROSIVE, /* FLUORINE */
	NOBLE, /* NEON */
	BASE_METAL, /* SODIUM */
	BASE_METAL, /* MAGNESIUM */
	BASE_METAL, /* ALUMINUM */
	COMMON, /* SILICON */
	COMMON, /* PHOSPHORUS */
	CORROSIVE, /* SULFUR */
	CORROSIVE, /* CHLORINE */
	NOBLE, /* ARGON */
	BASE_METAL, /* POTASSIUM */
	BASE_METAL, /* CALCIUM */
	BASE_METAL, /* SCANDIUM */
	BASE_METAL, /* TITANIUM */
	BASE_METAL, /* VANADIUM */
	BASE_METAL, /* CHROMIUM */
	BASE_METAL, /* MANGANESE */
	BASE_METAL, /* IRON */
	BASE_METAL, /* COBALT */
	BASE_METAL, /* NICKEL */
	BASE_METAL, /* COPPER */
	BASE_METAL, /* ZINC */
	BASE_METAL, /* GALLIUM */
	BASE_METAL, /* GERMANIUM */
	COMMON, /* ARSENIC */
	COMMON, /* SELENIUM */
	CORROSIVE, /* BROMINE */
	NOBLE, /* KRYPTON */
	BASE_METAL, /* RUBIDIUM */
	BASE_METAL, /* STRONTIUM */
	BASE_METAL, /* YTTRIUM */
	BASE_METAL, /* ZIRCONIUM */
	BASE_METAL, /* NIOBIUM */
	BASE_METAL, /* MOLYBDENUM */
	RADIOACTIVE, /* TECHNETIUM */
	BASE_METAL, /* RUTHENIUM */
	BASE_METAL, /* RHODIUM */
	PRECIOUS, /* PALLADIUM */
	PRECIOUS, /* SILVER */
	BASE_METAL, /* CADMIUM */
	BASE_METAL, /* INDIUM */
	BASE_METAL, /* TIN */
	BASE_METAL, /* ANTIMONY */
	BASE_METAL, /* TELLURIUM */
	CORROSIVE, /* IODINE */
	NOBLE, /* XENON */
	BASE_METAL, /* CESIUM */
	BASE_METAL, /* BARIUM */
	RARE_EARTH, /* LANTHANUM */
	RARE_EARTH, /* CERIUM */
	RARE_EARTH, /* PRASEODYMIUM */
	RARE_EARTH, /* NEODYMIUM */
	RARE_EARTH, /* PROMETHIUM */
	RARE_EARTH, /* SAMARIUM */
	RARE_EARTH, /* EUROPIUM */
	RARE_EARTH, /* GADOLINIUM */
	RARE_EARTH, /* TERBIUM */
	RARE_EARTH, /* DYPROSIUM */
	RARE_EARTH, /* HOLMIUM */
	RARE_EARTH, /* ERBIUM */
	RARE_EARTH, /* THULIUM */
	RARE_EARTH, /* YTTERBIUM */
	RARE_EARTH, /* LUTETIUM */
	BASE_METAL, /* HAFNIUM */
	BASE_METAL, /* TANTALUM */
	BASE_METAL, /* TUNGSTEN */
	BASE_METAL, /* RHENIUM */
	BASE_METAL, /* OSMIUM */
	PRECIOUS, /* IRIDIUM */
	PRECIOUS, /* PLATINUM */
	PRECIOUS, /* GOLD */
	BASE_METAL, /* MERCURY */
	BASE_METAL, /* THALLIUM */
	BASE_METAL, /* LEAD */
	BASE_METAL, /* BISMUTH */
	RADIOACTIVE, /* POLONIUM */
	RADIOACTIVE, /* ASTATINE */
	NOBLE, /* RADON */
	RADIOACTIVE, /* FRANCIUM */
	RADIOACTIVE, /* RADIUM */
	RADIOACTIVE, /* ACTINIUM */
	RADIOACTIVE, /* THORIUM */
	RADIOACTIVE, /* PROTACTINIUM */
	RADIOACTIVE, /* URANIUM */
	RADIOACTIVE, /* NEPTUNIUM */
	RADIOACTIVE, /* PLUTONIUM */

	COMMON, /* OZONE */
	COMMON, /* FREE RADICALS */
	COMMON, /* CARBON DIOXIDE */
	COMMON, /* CARBON MONOXIDE */
	COMMON, /* AMMONIA */
	COMMON, /* METHANE */
	COMMON, /* SULFURIC ACID */
	COMMON, /* HYDROCHLORIC ACID */
	COMMON, /* HYDROCYANIC ACID */
	COMMON, /* FORMIC ACID */
	COMMON, /* PHOSPHORIC ACID */
	COMMON, /* FORMALDEHYDE */
	COMMON, /* CYANOACETYLENE */
	COMMON, /* METHANOL */
	COMMON, /* ETHANOL */
	COMMON, /* SILICON MONOXIDE */
	COMMON, /* TITANIUM OXIDE */
	COMMON, /* ZIRCONIUM OXIDE */
	COMMON, /* WATER */
	COMMON, /* SILICON COMPOUNDS */
	COMMON, /* METAL OXIDES */
	EXOTIC, /* QUANTUM BLACK HOLES */
	EXOTIC, /* NEUTRONIUM */
	EXOTIC, /* MAGNETIC MONOPOLES */
	EXOTIC, /* DEGENERATE MATTER */
	EXOTIC, /* SUPER FLUIDS */
	EXOTIC, /* AGUUTI NODULES */
	COMMON, /* IRON COMPOUNDS */
	COMMON, /* ALUMINUM COMPOUNDS */
	COMMON, /* NITROUS OXIDE */
	COMMON, /* RADIOACTIVES */
	COMMON, /* HYDROCARBONS */
	COMMON, /* CARBON COMPOUNDS */
	EXOTIC, /* ANTIMATTER */
	EXOTIC, /* CHARON DUST */
	EXOTIC, /* REISBURG HELICES */
	EXOTIC, /* TZO CRYSTALS */
	COMMON, /* CALCIUM COMPOUNDS */
	COMMON, /* NITRIC ACID */
};

/*------------------------------ Global Data ------------------------------ */
#define NO_TECTONICS 0
#define LOW_TECTONICS 40
#define MED_TECTONICS 80
#define HIGH_TECTONICS 140
#define SUPER_TECTONICS 200

#define NO_DEPOSIT 0

#define TRACE_USEFUL MINERAL_DEPOSIT (FEW, LIGHT)
#define LIGHT_USEFUL MINERAL_DEPOSIT (MODERATE, LIGHT)
#define MEDIUM_USEFUL MINERAL_DEPOSIT (MODERATE, MEDIUM)
#define HEAVY_USEFUL MINERAL_DEPOSIT (MODERATE, HEAVY)
#define HUGE_USEFUL MINERAL_DEPOSIT (NUMEROUS, HEAVY)

const PlanetFrame planet_array[NUMBER_OF_PLANET_TYPES] =
{
	{ /* OOLITE_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				VIOLET_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (HIGH_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{HOLMIUM, MEDIUM_USEFUL},
			{ERBIUM, MEDIUM_USEFUL},
			{THULIUM, MEDIUM_USEFUL},
			{YTTERBIUM, MEDIUM_USEFUL},
			{LUTETIUM, MEDIUM_USEFUL},
			{PALLADIUM, MEDIUM_USEFUL},
			{SILVER, MEDIUM_USEFUL},
			{IRIDIUM, MEDIUM_USEFUL},
		},
		OOLITE_COLOR_TAB,
		OOLITE_XLAT_TAB,
		230, 2, 200, 150,
	},
	{ /* YTTRIC_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				VIOLET_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (HIGH_DENSITY, MEDIUM), /* Atmosphere and density */
		{
			{YTTERBIUM, HUGE_USEFUL},
			{YTTRIUM, HUGE_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		YTTRIC_COLOR_TAB,
		YTTRIC_XLAT_TAB,
		250, 2, 80, 200,
	},
	{ /* QUASI_DEGENERATE_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + TOPO_ALGO,
				GREEN_BODY), /* Color and type/size of planet */
		MED_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (HIGH_DENSITY, NOTHING), /* Atmosphere and density */
		{
			{DEGENERATE_MATTER, MEDIUM_USEFUL},
			{ACTINIUM, HUGE_USEFUL},
			{THORIUM, HUGE_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		QUASI_DEGENERATE_COLOR_TAB,
		QUASI_DEGENERATE_XLAT_TAB,
		500, 1, 0, 160,
	},
	{ /* LANTHANIDE_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				YELLOW_BODY), /* Color and type/size of planet */
		HIGH_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (HIGH_DENSITY, LIGHT), /* Atmosphere and density */
		{
			{LANTHANUM, MEDIUM_USEFUL},
			{CERIUM, MEDIUM_USEFUL},
			{PRASEODYMIUM, MEDIUM_USEFUL},
			{NEODYMIUM, MEDIUM_USEFUL},
			{PROMETHIUM, MEDIUM_USEFUL},
			{SAMARIUM, MEDIUM_USEFUL},
			{GADOLINIUM, MEDIUM_USEFUL},
			{TERBIUM, MEDIUM_USEFUL},
		},
		LANTHANIDE_COLOR_TAB,
		YTTRIC_XLAT_TAB,
		250, 2, 80, 200,
	},
	{ /* TREASURE_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + TOPO_ALGO,
				YELLOW_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (SUPER_DENSITY, LIGHT), /* Atmosphere and density */
		{
			{PALLADIUM, HEAVY_USEFUL},
			{SILVER, HEAVY_USEFUL},
			{SILVER, HEAVY_USEFUL},
			{IRIDIUM, HEAVY_USEFUL},
			{GOLD, HEAVY_USEFUL},
			{PLATINUM, HEAVY_USEFUL},
			{LEAD, MEDIUM_USEFUL},
			{NOTHING, NO_DEPOSIT},
		},
		TREASURE_COLOR_TAB,
		QUASI_DEGENERATE_XLAT_TAB,
		500, 1, 0, 160,
	},
	{ /* UREA_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				YELLOW_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (LOW_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{AMMONIA, MEDIUM_USEFUL},
			{FORMALDEHYDE, MEDIUM_USEFUL},
			{PRASEODYMIUM, LIGHT_USEFUL},
			{TERBIUM, LIGHT_USEFUL},
			{ALUMINUM, MEDIUM_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		UREA_COLOR_TAB,
		UREA_XLAT_TAB,
		230, 2, 200, 150,
	},
	{ /* METAL_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				ORANGE_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (HIGH_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{IRON, HEAVY_USEFUL},
			{NICKEL, MEDIUM_USEFUL},
			{VANADIUM, MEDIUM_USEFUL},
			{SILVER, MEDIUM_USEFUL},
			{URANIUM, HEAVY_USEFUL},
			{THORIUM, LIGHT_USEFUL},
			{GOLD, MEDIUM_USEFUL},
			{RADIUM, LIGHT_USEFUL},
		},
		METAL_COLOR_TAB,
		METAL_XLAT_TAB,
		230, 2, 200, 150,
	},
	{ /* RADIOACTIVE_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				ORANGE_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (SUPER_DENSITY, LIGHT), /* Atmosphere and density */
		{
			{ASTATINE, MEDIUM_USEFUL},
			{FRANCIUM, MEDIUM_USEFUL},
			{RADIUM, MEDIUM_USEFUL},
			{ACTINIUM, MEDIUM_USEFUL},
			{THORIUM, MEDIUM_USEFUL},
			{PROTACTINIUM, MEDIUM_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		RADIOACTIVE_COLOR_TAB,
		YTTRIC_XLAT_TAB,
		250, 2, 80, 200,
	},
	{ /* OPALESCENT_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				CYAN_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (LOW_DENSITY, NOTHING), /* Atmosphere and density */
		{
			{SAMARIUM, LIGHT_USEFUL},
			{GADOLINIUM, LIGHT_USEFUL},
			{TITANIUM, LIGHT_USEFUL},
			{LITHIUM, LIGHT_USEFUL},
			{SILICON, LIGHT_USEFUL},
			{ARSENIC, LIGHT_USEFUL},
			{PROTACTINIUM, LIGHT_USEFUL},
			{NOTHING, NO_DEPOSIT},
		},
		OPALESCENT_COLOR_TAB,
		OPALESCENT_XLAT_TAB,
		400, 1, 100, 190,
	},
	{ /* CYANIC_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + TOPO_ALGO,
				GREEN_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (LIGHT_DENSITY, LIGHT), /* Atmosphere and density */
		{
			{CYANOACETYLENE, HUGE_USEFUL},
			{ARGON, TRACE_USEFUL},
			{CYANOACETYLENE, HUGE_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		CYANIC_COLOR_TAB,
		QUASI_DEGENERATE_XLAT_TAB,
		500, 1, 0, 160,
	},
	{ /* ACID_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				GREEN_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (NORMAL_DENSITY, LIGHT), /* Atmosphere and density */
		{
			{SULFURIC_ACID, HEAVY_USEFUL},
			{HYDROCHLORIC_ACID, HEAVY_USEFUL},
			{FORMIC_ACID, HEAVY_USEFUL},
			{HYDROCYANIC_ACID, HEAVY_USEFUL},
			{PHOSPHORIC_ACID, HEAVY_USEFUL},
			{NITRIC_ACID, HEAVY_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		ACID_COLOR_TAB,
		YTTRIC_XLAT_TAB,
		250, 2, 80, 200,
	},
	{ /* ALKALI_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				GREEN_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (NORMAL_DENSITY, MEDIUM), /* Atmosphere and density */
		{
			{CALCIUM, MEDIUM_USEFUL},
			{BARIUM, MEDIUM_USEFUL},
			{STRONTIUM, MEDIUM_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		ALKALI_COLOR_TAB,
		YTTRIC_XLAT_TAB,
		250, 2, 80, 200,
	},
	{ /* HALIDE_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				GREEN_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (LOW_DENSITY, LIGHT), /* Atmosphere and density */
		{
			{FLUORINE, MEDIUM_USEFUL},
			{BROMINE, MEDIUM_USEFUL},
			{BROMINE, MEDIUM_USEFUL},
			{ASTATINE, MEDIUM_USEFUL},
			{IODINE, MEDIUM_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		HALIDE_COLOR_TAB,
		YTTRIC_XLAT_TAB,
		250, 2, 80, 200,
	},
	{ /* GREEN_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				GREEN_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (NORMAL_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{PRASEODYMIUM, HEAVY_USEFUL},
			{NEODYMIUM, HEAVY_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		GREEN_COLOR_TAB,
		UREA_XLAT_TAB,
		230, 2, 200, 150,
	},
	{ /* COPPER_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + TOPO_ALGO,
				GREEN_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (HIGH_DENSITY, MEDIUM), /* Atmosphere and density */
		{
			{COPPER, HUGE_USEFUL},
			{COPPER, HUGE_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		COPPER_COLOR_TAB,
		QUASI_DEGENERATE_XLAT_TAB,
		500, 1, 0, 160,
	},
	{ /* CARBIDE_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				RED_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (NORMAL_DENSITY, LIGHT), /* Atmosphere and density */
		{
			{CARBON, HEAVY_USEFUL},
			{CARBON, HEAVY_USEFUL},
			{CARBON, HEAVY_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		CARBIDE_COLOR_TAB,
		OPALESCENT_XLAT_TAB,
		400, 1, 100, 190,
	},
	{ /* ULTRAMARINE_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				BLUE_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (LIGHT_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{KRYPTON, MEDIUM_USEFUL},
			{COBALT, MEDIUM_USEFUL},
			{HOLMIUM, MEDIUM_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		ULTRAMARINE_COLOR_TAB,
		UREA_XLAT_TAB,
		200, 2, 100, 100,
	},
	{ /* NOBLE_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				BLUE_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (LIGHT_DENSITY, LIGHT), /* Atmosphere and density */
		{
			{NEON, LIGHT_USEFUL},
			{RADON, LIGHT_USEFUL},
			{ARGON, LIGHT_USEFUL},
			{KRYPTON, LIGHT_USEFUL},
			{XENON, LIGHT_USEFUL},
			{HELIUM, LIGHT_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		NOBLE_COLOR_TAB,
		YTTRIC_XLAT_TAB,
		250, 2, 80, 200,
	},
	{ /* AZURE_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				BLUE_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (LOW_DENSITY, MEDIUM), /* Atmosphere and density */
		{
			{INDIUM, LIGHT_USEFUL},
			{MOLYBDENUM, LIGHT_USEFUL},
			{VANADIUM, LIGHT_USEFUL},
			{RT_SUPER_FLUID, TRACE_USEFUL},
			{NEON, HEAVY_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		AZURE_COLOR_TAB,
		UREA_XLAT_TAB,
		230, 2, 200, 150,
	},
	{ /* CHONDRITE_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				PURPLE_BODY), /* Color and type/size of planet */
		HIGH_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (NORMAL_DENSITY, NOTHING), /* Atmosphere and density */
		{
			{ETHANOL, HEAVY_USEFUL},
			{FREE_RADICALS, HEAVY_USEFUL},
			{CARBON, HEAVY_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		CHONDRITE_COLOR_TAB,
		CHONDRITE_XLAT_TAB,
		500, 1, 100, 190,
	},
	{ /* PURPLE_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				PURPLE_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (LOW_DENSITY, LIGHT), /* Atmosphere and density */
		{
			{RHENIUM, MEDIUM_USEFUL},
			{CADMIUM, MEDIUM_USEFUL},
			{NEUTRONIUM, TRACE_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		PURPLE_COLOR_TAB,
		UREA_XLAT_TAB,
		230, 2, 200, 150,
	},
	{ /* SUPER_DENSE_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + TOPO_ALGO,
				PURPLE_BODY), /* COLOR AND TYPE/SIZE OF PLANET */
		HIGH_TECTONICS, /* TECTONICS - SCALED WITH EARTH AT 82    */
		MAKE_BYTE (SUPER_DENSITY, HEAVY), /* ATMOSPHERE AND DENSITY */
		{
			{LEAD, MEDIUM_USEFUL},
			{OSMIUM, MEDIUM_USEFUL},
			{NEUTRONIUM, HEAVY_USEFUL},
			{NEUTRONIUM, MEDIUM_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		SUPER_DENSE_COLOR_TAB,
		QUASI_DEGENERATE_XLAT_TAB,
		500, 1, 0, 160,
	},
	{ /* PELLUCID_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				PURPLE_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (LOW_DENSITY, LIGHT), /* Atmosphere and density */
		{
			{TZO_CRYSTALS, TRACE_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		PELLUCID_COLOR_TAB,
		OPALESCENT_XLAT_TAB,
		400, 1, 100, 190,
	},
	{ /* DUST_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				RED_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (LOW_DENSITY, MEDIUM), /* Atmosphere and density */
		{
			{BISMUTH, LIGHT_USEFUL},
			{ALUMINUM, LIGHT_USEFUL},
			{POTASSIUM, LIGHT_USEFUL},
			{CARBON, LIGHT_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		DUST_COLOR_TAB,
		YTTRIC_XLAT_TAB,
		250, 2, 80, 200,
	},
	{ /* CRIMSON_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				RED_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (NORMAL_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{BARIUM, LIGHT_USEFUL},
			{BORON, LIGHT_USEFUL},
			{BERYLLIUM, LIGHT_USEFUL},
			{BISMUTH, LIGHT_USEFUL},
			{BROMINE, LIGHT_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		MAROON_COLOR_TAB,
		UREA_XLAT_TAB,
		230, 2, 200, 150,
	},
	{ /* CIMMERIAN_WORLD -- CHANGED TO DIAMOND WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + TOPO_ALGO,
				WHITE_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (LOW_DENSITY, NOTHING), /* Atmosphere and density */
		{
			{RT_SUPER_FLUID, HUGE_USEFUL},
			{MAGNETIC_MONOPOLES, MEDIUM_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		SELENIC_COLOR_TAB,
		SAPPHIRE_XLAT_TAB,
		500, 1, 0, 160,
	},
	{ /* INFRARED_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				RED_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (NORMAL_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{MERCURY, HEAVY_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		INFRARED_COLOR_TAB,
		OPALESCENT_XLAT_TAB,
		400, 1, 100, 190,
	},
	{ /* SELENIC_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + CRATERED_ALGO,
				WHITE_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (LOW_DENSITY, LIGHT), /* Atmosphere and density */
		{
			{IRON, MEDIUM_USEFUL},
			{ALUMINUM, MEDIUM_USEFUL},
			{CALCIUM, MEDIUM_USEFUL},
			{TITANIUM, HUGE_USEFUL},
			{CARBON, TRACE_USEFUL},
			{WATER, TRACE_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		SELENIC_COLOR_TAB,
		UREA_XLAT_TAB,
		230, 2, 200, 150,
	},
	{ /* AURIC_WORLD */
		MAKE_BYTE (SMALL_ROCKY_WORLD + TOPO_ALGO,
				YELLOW_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (HIGH_DENSITY, MEDIUM), /* Atmosphere and density */
		{
			{GOLD, HUGE_USEFUL},
			{GOLD, HUGE_USEFUL},
			{GOLD, HUGE_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		AURIC_COLOR_TAB,
		QUASI_DEGENERATE_XLAT_TAB,
		500, 1, 0, 160,
	},


	{ /* FLUORESCENT_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + CRATERED_ALGO,
				VIOLET_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (HIGH_DENSITY, LIGHT), /* Atmosphere and density */
		{
			{TECHNETIUM, MEDIUM_USEFUL},
			{NEON, MEDIUM_USEFUL},
			{RADON, LIGHT_USEFUL},
			{POTASSIUM, LIGHT_USEFUL},
			{THORIUM, LIGHT_USEFUL},
			{ARGON, TRACE_USEFUL},
			{PROTACTINIUM,TRACE_USEFUL},
			{PLUTONIUM, LIGHT_USEFUL},
		},
		FLUORESCENT_COLOR_TAB,
		OPALESCENT_XLAT_TAB,
		400, 1, 100, 190,
	},
	{ /* ULTRAVIOLET_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + CRATERED_ALGO,
				VIOLET_BODY), /* Color and type/size of planet */
		MED_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (HIGH_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{POLONIUM, HEAVY_USEFUL},
			{GOLD, MEDIUM_USEFUL},
			{PHOSPHORUS, HEAVY_USEFUL},
			{SCANDIUM, MEDIUM_USEFUL},
			{TZO_CRYSTALS, TRACE_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		ULTRAVIOLET_COLOR_TAB,
		YTTRIC_XLAT_TAB,
		250, 2, 80, 200,
	},
	{ /* PLUTONIC_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + CRATERED_ALGO,
				YELLOW_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (HIGH_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{BERYLLIUM, HUGE_USEFUL},
			{BORON, HUGE_USEFUL},
			{LANTHANUM, MEDIUM_USEFUL},
			{ASTATINE, MEDIUM_USEFUL},
			{FRANCIUM, MEDIUM_USEFUL},
			{TITANIUM, LIGHT_USEFUL},
			{CERIUM, MEDIUM_USEFUL},
			{NOTHING, NO_DEPOSIT},
		},
		PLUTONIC_COLOR_TAB,
		YTTRIC_XLAT_TAB,
		250, 2, 80, 200,
	},
	{ /* RAINBOW_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + TOPO_ALGO,
				YELLOW_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (LOW_DENSITY, LIGHT), /* Atmosphere and density */
		{
			{GOLD, HEAVY_USEFUL},
			{XENON, HEAVY_USEFUL},
			{PROTACTINIUM, HEAVY_USEFUL},
			{PRASEODYMIUM, HEAVY_USEFUL},
			{PLUTONIUM, HEAVY_USEFUL},
			{ANTIMATTER, LIGHT_USEFUL},
			{NEUTRONIUM, TRACE_USEFUL},
			{TZO_CRYSTALS, LIGHT_USEFUL},
		},
		RAINBOW_COLOR_TAB,
		RAINBOW_XLAT_TAB,
		500, 1, 20, 100,
	},
	{ /* CRACKED_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + CRATERED_ALGO,
				ORANGE_BODY), /* Color and type/size of planet */
		SUPER_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (NORMAL_DENSITY, NOTHING), /* Atmosphere and density */
		{
			{PALLADIUM, HUGE_USEFUL},
			{IRIDIUM, HUGE_USEFUL},
			{TECHNETIUM, HUGE_USEFUL},
			{POLONIUM, HUGE_USEFUL},
			{SODIUM, HUGE_USEFUL},
			{MANGANESE, HUGE_USEFUL},
			{CHROMIUM, HUGE_USEFUL},
			{PLUTONIUM, HUGE_USEFUL},
		},
		CRACKED_COLOR_TAB,
		CRACKED_XLAT_TAB,
		500, 1, 0, 185,
	},
	{ /* SAPPHIRE_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + TOPO_ALGO,
				CYAN_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (LOW_DENSITY, NOTHING), /* Atmosphere and density */
		{
			{REISBURG_HELICES, HUGE_USEFUL},
			{RT_SUPER_FLUID, MEDIUM_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		SAPPHIRE_COLOR_TAB,
		SAPPHIRE_XLAT_TAB,
		80, 1, 0, 128,
	},
	{ /* ORGANIC_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + TOPO_ALGO,
				CYAN_BODY), /* Color and type/size of planet */
		MED_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (NORMAL_DENSITY, LIGHT), /* Atmosphere and density */
		{
			{FREE_RADICALS, HEAVY_USEFUL},
			{FORMALDEHYDE, HEAVY_USEFUL},
			{CARBON, HEAVY_USEFUL},
			{CARBON_DIOXIDE, HEAVY_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		ORGANIC_COLOR_TAB,
		QUASI_DEGENERATE_XLAT_TAB,
		500, 1, 0, 160,
	},
	{ /* XENOLITHIC_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + CRATERED_ALGO,
				CYAN_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (NORMAL_DENSITY, MEDIUM), /* Atmosphere and density */
		{
			{ALUMINUM, HUGE_USEFUL},
			{PLATINUM, LIGHT_USEFUL},
			{GERMANIUM, TRACE_USEFUL},
			{URANIUM, MEDIUM_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		XENOLITHIC_COLOR_TAB,
		OPALESCENT_XLAT_TAB,
		400, 1, 100, 190,
	},
	{ /* REDUX_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + CRATERED_ALGO,
				GREEN_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (NORMAL_DENSITY, LIGHT), /* Atmosphere and density */
		{
			{BROMINE, MEDIUM_USEFUL},
			{OXYGEN, MEDIUM_USEFUL},
			{FLUORINE, MEDIUM_USEFUL},
			{SULFUR, MEDIUM_USEFUL},
			{CHLORINE, MEDIUM_USEFUL},
			{IODINE, MEDIUM_USEFUL},
			{ZIRCONIUM, LIGHT_USEFUL},
			{NOTHING, NO_DEPOSIT},
		},
		REDUX_COLOR_TAB,
		REDUX_XLAT_TAB,
		500, 1, 0, 190,
	},
	{ /* PRIMORDIAL_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + CRATERED_ALGO,
				GREEN_BODY), /* Color and type/size of planet */
		SUPER_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (NORMAL_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{CESIUM, MEDIUM_USEFUL},
			{BARIUM, MEDIUM_USEFUL},
			{RUBIDIUM, MEDIUM_USEFUL},
			{METHANE, HUGE_USEFUL},
			{AMMONIA, HUGE_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		PRIMORDIAL_COLOR_TAB,
		YTTRIC_XLAT_TAB,
		250, 2, 10, 200,
	},
	{ /* EMERALD_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + TOPO_ALGO,
				GREEN_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (LOW_DENSITY, NOTHING), /* Atmosphere and density */
		{
			{AGUUTI_NODULES, HUGE_USEFUL},
			{ANTIMATTER, MEDIUM_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		EMERALD_COLOR_TAB,
		SAPPHIRE_XLAT_TAB,
		80, 1, 0, 128,
	},
	{ /* CHLORINE_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + CRATERED_ALGO,
				GREEN_BODY), /* Color and type/size of planet */
		HIGH_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (NORMAL_DENSITY, LIGHT), /* Atmosphere and density */
		{
			{CHLORINE, HEAVY_USEFUL},
			{CHLORINE, HEAVY_USEFUL},
			{HYDROCHLORIC_ACID, HEAVY_USEFUL},
			{HYDROCHLORIC_ACID, HEAVY_USEFUL},
			{ZINC, LIGHT_USEFUL},
			{GALLIUM, TRACE_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		CHLORINE_COLOR_TAB,
		CHLORINE_XLAT_TAB,
		500, 1, 0, 190,
	},
	{ /* MAGNETIC_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + CRATERED_ALGO,
				GREEN_BODY), /* Color and type/size of planet */
		HIGH_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (HIGH_DENSITY, NOTHING), /* Atmosphere and density */
		{
			{ZINC, HEAVY_USEFUL},
			{NICKEL, MEDIUM_USEFUL},
			{MAGNETIC_MONOPOLES, TRACE_USEFUL},
			{NIOBIUM, LIGHT_USEFUL},
			{IRON, HEAVY_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		MAGNETIC_COLOR_TAB,
		OPALESCENT_XLAT_TAB,
		400, 1, 100, 190,
	},
	{ /* WATER_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + CRATERED_ALGO,
				BLUE_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (NORMAL_DENSITY, MEDIUM), /* Atmosphere and density */
		{
			{IRON, LIGHT_USEFUL},
			{ALUMINUM, LIGHT_USEFUL},
			{WATER, HUGE_USEFUL},
			{GOLD, TRACE_USEFUL},
			{URANIUM, TRACE_USEFUL},
			{MOLYBDENUM, TRACE_USEFUL},
			{NEON, TRACE_USEFUL},
			{NEODYMIUM, TRACE_USEFUL},
		},
		WATER_COLOR_TAB,
		CHLORINE_XLAT_TAB,
		500, 1, 0, 190,
	},
	{ /* TELLURIC_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + CRATERED_ALGO,
				BLUE_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (NORMAL_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{IRIDIUM, MEDIUM_USEFUL},
			{RUTHENIUM, MEDIUM_USEFUL},
			{THALLIUM, MEDIUM_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		TELLURIC_COLOR_TAB,
		YTTRIC_XLAT_TAB,
		250, 2, 80, 200,
	},
	{ /* HYDROCARBON_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + TOPO_ALGO,
				BLUE_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (NORMAL_DENSITY, LIGHT), /* Atmosphere and density */
		{
			{HYDROCARBONS, HUGE_USEFUL},
			{BISMUTH, LIGHT_USEFUL},
			{TANTALUM, TRACE_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		HYDROCARBON_COLOR_TAB,
		QUASI_DEGENERATE_XLAT_TAB,
		500, 1, 0, 160,
	},
	{ /* IODINE_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + CRATERED_ALGO,
				GREEN_BODY), /* Color and type/size of planet */
		MED_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (LOW_DENSITY, MEDIUM), /* Atmosphere and density */
		{
			{IODINE, HEAVY_USEFUL},
			{MAGNESIUM, LIGHT_USEFUL},
			{TUNGSTEN, TRACE_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		IODINE_COLOR_TAB,
		UREA_XLAT_TAB,
		230, 2, 200, 150,
	},
	{ /* VINYLOGOUS_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + CRATERED_ALGO,
				PURPLE_BODY), /* Color and type/size of planet */
		LOW_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (NORMAL_DENSITY, NOTHING), /* Atmosphere and density */
		{
			{TITANIUM, LIGHT_USEFUL},
			{ARSENIC, LIGHT_USEFUL},
			{POTASSIUM, LIGHT_USEFUL},
			{RHENIUM, LIGHT_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		VINYLOGOUS_COLOR_TAB,
		OPALESCENT_XLAT_TAB,
		400, 1, 100, 190,
	},
	{ /* RUBY_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + TOPO_ALGO,
				RED_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (LOW_DENSITY, LIGHT), /* Atmosphere and density */
		{
			{TZO_CRYSTALS, HUGE_USEFUL},
			{NEUTRONIUM, MEDIUM_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		RUBY_COLOR_TAB,
		SAPPHIRE_XLAT_TAB,
		80, 1, 0, 128,
	},
	{ /* MAGMA_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + TOPO_ALGO,
				RED_BODY), /* Color and type/size of planet */
		SUPER_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (HIGH_DENSITY, LIGHT), /* Atmosphere and density */
		{
			{LEAD, HEAVY_USEFUL},
			{NICKEL, HEAVY_USEFUL},
			{IRON, HEAVY_USEFUL},
			{GOLD, HEAVY_USEFUL},
			{SILVER, MEDIUM_USEFUL},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		MAGMA_COLOR_TAB,
		QUASI_DEGENERATE_XLAT_TAB,
		500, 1, 0, 160,
	},
	{ /* MAROON_WORLD */
		MAKE_BYTE (LARGE_ROCKY_WORLD + CRATERED_ALGO,
				RED_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (LOW_DENSITY, MEDIUM), /* Atmosphere and density */
		{
			{CESIUM, MEDIUM_USEFUL},
			{SILICON, MEDIUM_USEFUL},
			{PHOSPHORUS, MEDIUM_USEFUL},
			{RHODIUM, MEDIUM_USEFUL},
			{CADMIUM, MEDIUM_USEFUL},
			{XENON, LIGHT_USEFUL},
			{BROMINE, LIGHT_USEFUL},
			{NOTHING, NO_DEPOSIT},
		},
		CRIMSON_COLOR_TAB,
		UREA_XLAT_TAB,
		230, 2, 200, 150,
	},

	{
		MAKE_BYTE (GAS_GIANT + GAS_GIANT_ALGO,
				BLUE_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (GAS_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		BLU_GAS_COLOR_TAB,
		GAS_XLAT_TAB,
		10, 2, 8, 29,
	},
	{
		MAKE_BYTE (GAS_GIANT + GAS_GIANT_ALGO,
				CYAN_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (GAS_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		CYA_GAS_COLOR_TAB,
		GAS_XLAT_TAB,
		10, 2, 8, 29,
	},
	{
		MAKE_BYTE (GAS_GIANT + GAS_GIANT_ALGO,
				GREEN_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (GAS_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		GRN_GAS_COLOR_TAB,
		GAS_XLAT_TAB,
		10, 2, 8, 29,
	},
	{
		MAKE_BYTE (GAS_GIANT + GAS_GIANT_ALGO,
				GRAY_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (GAS_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		GRY_GAS_COLOR_TAB,
		GAS_XLAT_TAB,
		10, 2, 8, 29,
	},
	{
		MAKE_BYTE (GAS_GIANT + GAS_GIANT_ALGO,
				ORANGE_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (GAS_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		ORA_GAS_COLOR_TAB,
		GAS_XLAT_TAB,
		10, 2, 8, 29,
	},
	{
		MAKE_BYTE (GAS_GIANT + GAS_GIANT_ALGO,
				PURPLE_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (GAS_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		PUR_GAS_COLOR_TAB,
		GAS_XLAT_TAB,
		10, 2, 8, 29,
	},
	{
		MAKE_BYTE (GAS_GIANT + GAS_GIANT_ALGO,
				RED_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (GAS_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		RED_GAS_COLOR_TAB,
		GAS_XLAT_TAB,
		10, 2, 8, 29,
	},
	{
		MAKE_BYTE (GAS_GIANT + GAS_GIANT_ALGO,
				VIOLET_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (GAS_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		VIO_GAS_COLOR_TAB,
		GAS_XLAT_TAB,
		10, 2, 8, 29,
	},
	{ /* A Jupiter-like World */
		MAKE_BYTE (GAS_GIANT + GAS_GIANT_ALGO,
				YELLOW_BODY), /* Color and type/size of planet */
		NO_TECTONICS, /* Tectonics - Scaled with Earth at 82    */
		MAKE_BYTE (GAS_DENSITY, HEAVY), /* Atmosphere and density */
		{
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
			{NOTHING, NO_DEPOSIT},
		},
		YEL_GAS_COLOR_TAB,
		GAS_XLAT_TAB,
		10, 2, 8, 29,
	},
};
"""




if __name__ == "__main__":
   main()
