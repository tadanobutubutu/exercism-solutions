
module perfect_numbers
  implicit none

contains

  character(len=9) function classify(num)
    integer, intent(in) :: num
    integer :: divisor, paired_divisor
    integer(kind=8) :: divisor_sum

    if (num <= 0) then
      classify = "ERROR"
      return
    end if

    divisor_sum = 1_8
    if (num == 1) divisor_sum = 0_8
    divisor = 2
    do while (divisor <= num / divisor)
      if (mod(num, divisor) == 0) then
        paired_divisor = num / divisor
        divisor_sum = divisor_sum + int(divisor, kind=8)
        if (paired_divisor /= divisor) divisor_sum = divisor_sum + int(paired_divisor, kind=8)
      end if
      divisor = divisor + 1
    end do

    if (divisor_sum == int(num, kind=8)) then
      classify = "perfect"
    else if (divisor_sum > int(num, kind=8)) then
      classify = "abundant"
    else
      classify = "deficient"
    end if
  end function

end module
