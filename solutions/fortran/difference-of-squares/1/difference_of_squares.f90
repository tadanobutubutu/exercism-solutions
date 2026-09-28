module difference_of_squares
  implicit none
contains

  integer function square_of_sum(n)
    integer, intent(in) :: n
    integer :: i, total
    total = 0
    do i = 1, n
      total = total + i
    end do
    square_of_sum = total * total
  end function square_of_sum

  integer function sum_of_squares(n)
    integer, intent(in) :: n
    integer :: i
    sum_of_squares = 0
    do i = 1, n
      sum_of_squares = sum_of_squares + i * i
    end do
  end function sum_of_squares

  integer function difference(n)
    integer, intent(in) :: n
    difference = square_of_sum(n) - sum_of_squares(n)
  end function difference

end module difference_of_squares
