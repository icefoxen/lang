program readtest
  ! This turns off implicit typing, which sucks.
  implicit none
  real :: a, b, c, r
  real :: pi = 3.14159
  print*, "a, b and c, uninitialized, are ", a, b, c
  print*, "Now type three numbers separated by spaces, commas or /'s"
  read*, a, b, c
  print*, "You typed: ", a, b, c
  print*, "Now give me the radius of a circle to compute the area of."
  read*, r
  a = pi * r**2
  print*, "The area is:", a
  if (a < 1000) then
     print*, "The area is less than 1000"
  else
     print*, "The area is greater than 1000"
  end if
end program readtest
