// Now this stuff is pretty damn cool.
myobj := Object clone
myobj forward := method( 
  write("sender = ", sender, "\n")
  write("message name = ", thisMessage name, "\n")
  args := thisMessage argsEvaluatedIn(sender)
  args foreach(i, v, write("arg", i, " = ", v, "\n") )
)
myobj thisMessageDNE

myobj anotherBadMessage( "foo", 10,  "bop", myobj )


// We can resend messages up the heirarchy, as well
A := Object clone
A m := method(write("in A\n"))
B := A clone
B m := method(write("in B\n"); resend)
B m



// The typical "super.foo()" stuff as well
Dog := Object clone
Dog bark := method("woof!" println)

myDog := Dog clone
myDog bark := method(
  "ruf!" println
  Dog getSlot("bark") performOn(self)  // Error hehere, for some reason
)

write( "Dog barking:\n" )
Dog bark
"\n" print
write( "myDog barking:\n" )
myDog bark
