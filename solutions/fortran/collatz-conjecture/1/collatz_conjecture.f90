
module collatz_conjecture
  use iso_fortran_env, only: int64
  implicit none
contains

  integer function steps(i)
    integer, intent(in) :: i
    integer(int64) :: value

    if (i < 1) then
      steps = -1
      return
    end if

    value = int(i, int64)
    steps = 0
    do while (value /= 1_int64)
      if (mod(value, 2_int64) == 0_int64) then
        value = value / 2_int64
      else
        value = 3_int64 * value + 1_int64
      end if
      steps = steps + 1
    end do
  end function

end module
