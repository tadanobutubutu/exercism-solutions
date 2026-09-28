module sum_of_multiples
  implicit none

contains

  function sum_multiples(factors, limit) result(res)
    integer, intent(in) :: factors(:), limit
    integer :: res

    integer :: candidate, i
    logical :: matched
    res = 0
    do candidate = 1, limit - 1
      matched = .false.
      do i = 1, size(factors)
        if (factors(i) == 0) cycle
        if (mod(candidate, abs(factors(i))) == 0) then
          matched = .true.
          exit
        end if
      end do
      if (matched) res = res + candidate
    end do
  end function sum_multiples

end module sum_of_multiples
