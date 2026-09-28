module nth_prime
  implicit none
contains

  ! get nth prime
  integer function prime(n)
    integer, intent(in) :: n
    integer :: candidate, divisor, count
    logical :: is_prime

    prime = -1
    if (n <= 0) return
    if (n == 1) then
      prime = 2
      return
    end if

    count = 1
    candidate = 1
    do while (count < n)
      candidate = candidate + 2
      is_prime = .true.
      divisor = 3
      do while (divisor * divisor <= candidate)
        if (mod(candidate, divisor) == 0) then
          is_prime = .false.
          exit
        end if
        divisor = divisor + 2
      end do
      if (is_prime) count = count + 1
    end do
    prime = candidate
  end function

end module
