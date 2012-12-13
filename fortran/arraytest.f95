program arraytest
  implicit none

  ! index variable needs to be declared
  integer :: i, j, k
  integer :: len = 9
  ! Here we explicitly say the array is indexed from 0-9
  real, dimension(0:9) :: arr
  real :: sum = 0

  ! Here by default the array is indexed from 1 to 10
  real, dimension(10) :: arr2

  ! We really do need to pre-declare all our data.
  real, dimension(10, 10) :: d, e, f

  do i = 0, len
     arr(i) = i
     arr2(i+1) = i+1
  end do
  print*, "Array filled with", arr

  do i = 0, len
     sum = sum + arr(i)
  end do
  print*, "Sum of array:", sum

  sum = 0
  do i = 0, 10
     sum = sum + arr2(i)
  end do
  print*, "Array 2 sum:", sum

  ! Loops can be nested of course
  do i = 1, 10
     do j = 1, 10
        d(i, j) = 0
        do k = 1, 10
           d(i, j) = d(i, j) + e(i, k) + f(k, i)

           ! Break
           if (d(i,j) < 0) then
              print*, "Breaking"
              exit
           end if
        end do
     end do
  end do

  print*, d

end program arraytest
