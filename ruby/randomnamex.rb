#!/usr/bin/ruby
# Let's see how ruby works for this...

FILE="/home/icefox/writings/Namex.txt"

def slurpFile( f )
   file = open( f )
   lines = file.readlines

   newlines = []
   lines.each do |line|
      newlines.push line.chomp
   end

   return newlines
end

def dumpFile( f, lines )
   lines.sort!
   lines.uniq!
   f = open( f, 'w' )
   lines.each do |line|
      f.write line + "\n"
   end
   f.close
end

def getRandomName( lines )
   randNum = (rand * lines.length).floor
   return lines[randNum]
end

def getRandomNames( lines, number )
   accm = []
   number.times do
      accm.push getRandomName( lines )
   end
   return accm
end

def printRandomNames( num )
   lines = slurpFile( FILE )
   randlines = getRandomNames( lines, num )
   randlines.each do |line|
      print line + "\n"
   end
end

def addLines( lines )
   newlines = slurpFile( FILE )
   lines.each do |name|
      if name != '-a' then # I need to slice arrays!  Waaaah!
         newlines.push name
      end
   end
   dumpFile( FILE, newlines )
end

def main()
   if ARGV[0] == '-a' then
      addLines( ARGV )
   else
      printRandomNames( Integer( ARGV[0] ) )
   end
end
   
main()
