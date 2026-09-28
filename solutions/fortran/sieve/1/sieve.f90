module sieve
  implicit none

contains

  function primes(limit) result(array)
    integer, intent(in) :: limit
    integer, allocatable :: array(:)

    logical, allocatable :: is_prime(:)
    integer :: candidate, multiple, count_primes, index

    if (limit < 2) then
      allocate(array(0))
      return
    end if
    allocate(is_prime(0:limit))
    is_prime = .true.
    is_prime(0:1) = .false.
    candidate = 2
    do while (candidate <= limit / candidate)
      if (is_prime(candidate)) then
        multiple = candidate * candidate
        do while (multiple <= limit)
          is_prime(multiple) = .false.
          multiple = multiple + candidate
        end do
      end if
      candidate = candidate + 1
    end do
    count_primes = count(is_prime)
    allocate(array(count_primes))
    index = 0
    do candidate = 2, limit
      if (is_prime(candidate)) then
        index = index + 1
        array(index) = candidate
      end if
    end do
  end function primes

end module sieve
