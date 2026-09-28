
module armstrong_numbers
  implicit none
contains

  logical function isArmstrongNumber(i)
    integer, intent(in) :: i
    integer :: value, digit, number_of_digits, total

    if (i < 0) then
      isArmstrongNumber = .false.
      return
    end if

    number_of_digits = 1
    value = i
    do while (value >= 10)
      number_of_digits = number_of_digits + 1
      value = value / 10
    end do

    total = 0
    value = i
    do
      digit = mod(value, 10)
      total = total + digit ** number_of_digits
      value = value / 10
      if (value == 0) exit
    end do
    isArmstrongNumber = (total == i)

  end function

end module
