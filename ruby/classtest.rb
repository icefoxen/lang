# Example of OO programming stuff.

class Song
  # initialize is the constructor method; it gets called whenever a new
  # object is created
   def initialize( name, artist, duration )
      # Remember; instance variables start with a @
      @name = name
      @artist = artist
      @duration = duration
   end
end

# Let's test it out
a = Song.new( "Elevation", "U2", 440 )
# Prints out basic values, a la Smalltalk
a.inspect


# Hey, it looks like ye can define these things piecewise!  Great!
class Song
   # to_s means toString, a la Java.  Let's override it, ne?
   def to_s
      # The #{...} is inline string substitution; any expression within the
      # brackets is evaluated.  Shibby, ne?
      "Song: #{@name} -- #{@artist} (#{@duration})"
   end
end

b = Song.new( "In The End", "Linkin Park", 340 )
b.to_s


# Yay, now subclassing!
class KaraokeSong < Song
   def initialize( name, artist, duration, lyrics )
      super( name, artist, duration )
      @lyrics = lyrics
   end

   def to_s
      # If you invoke "super" with no arguments, it sends a message to the
      # object's parent, telling it to a) invoke the same named method, and
      # b) passing all the parameters that were passed to the current method.
      super + "\n[#{@lyrics}]"
   end
end

c = KaraokeSong.new( "My Way", "Sinatra", 225, "And now the..." )
c.to_s


class Song
   # Attributes!  Shortcuts!  Keywords!  Lispy!  Yaaay!!!!
   # Anyhoo, this defines three "getter" methods: artist, name, and duration.
   # They return the values of the respective instance vars.
   attr_reader :name, :artist, :duration
   # This does exactly what you would think.  When ye do, for instance,
   # Song.duration = foo, it actually does Song.duration=( foo ), where
   # duration= is a method defined automatically.
   attr_writer :duration
end

d = Song.new( "FF6 Prelude", "FFMusic DJ", 491 )

d.duration
d.duration = 488
d.duration


class Song
   # And of course, you can define your own attributes.
   def durationInMinutes
      @duration / 60.0  # Force floating point
   end

   # And the setter, also...
   def durationInMinutes=( value)
      @duration = (value * 60).to_i
   end
end
