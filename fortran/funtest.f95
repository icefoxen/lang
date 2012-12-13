
! We can rename the return variable... yippee
!function circle_area2(r) result (area)
!  implicit none
!  real :: r
!  real :: area
!  real, parameter :: pi = 3.14159
!
!  area = pi * r**2
!end function circle_area2
  

program funtest
  implicit none

  real :: res = 0
  res = circleArea(2.0)
  print*, res
  
end program funtest



function circleArea(r) 
  ! ye gads, really?
  implicit none
  ! 'parameter' denotes a constant
  real, parameter :: pi = 3.14159
  real :: r ! This is the argument... really?
  real :: circleArea ! This is the function return... REALLY?

  circleArea = pi * r**2  
end function circleArea
