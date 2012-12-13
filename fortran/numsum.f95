program numsum
  implicit none
  real :: number, sum = 0

  ! Endless do
  do
     print*, "Give a number to sum, or 0 to quit"
     read*, number
     if (number == 0) then
        ! Break!
        ! 'continue' is 'cycle'
        exit
     end if
     sum = sum + number
  end do
  print*, "Sum is:", sum
end program numsum
