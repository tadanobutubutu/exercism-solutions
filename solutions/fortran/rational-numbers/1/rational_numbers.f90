
module rational_numbers
  implicit none
contains

  function add(r1,r2)
    integer, dimension(2), intent(in) :: r1, r2
    integer :: add(2)
    add = reduce([r1(1) * r2(2) + r2(1) * r1(2), r1(2) * r2(2)])
  end function

  function sub(r1,r2)
    integer, dimension(2), intent(in) :: r1, r2
    integer :: sub(2)
    sub = reduce([r1(1) * r2(2) - r2(1) * r1(2), r1(2) * r2(2)])
  end function

  function mul(r1,r2)
    integer, dimension(2), intent(in) :: r1, r2
    integer :: mul(2)
    mul = reduce([r1(1) * r2(1), r1(2) * r2(2)])
  end function

  function div(r1,r2)
    integer, dimension(2), intent(in) :: r1, r2
    integer :: div(2)
    div = reduce([r1(1) * r2(2), r1(2) * r2(1)])
  end function

  function rational_abs(r1)
    integer, dimension(2), intent(in) :: r1
    integer :: rational_abs(2)
    rational_abs = reduce([abs(r1(1)), abs(r1(2))])
  end function

  function rational_to_pow(r1, ex)
    integer, dimension(2), intent(in) :: r1
    integer, intent(in) :: ex
    integer :: rational_to_pow(2)
    if (ex == 0) then
      rational_to_pow = [1, 1]
    else if (ex > 0) then
      rational_to_pow = reduce([r1(1) ** ex, r1(2) ** ex])
    else
      rational_to_pow = reduce([r1(2) ** abs(ex), r1(1) ** abs(ex)])
    end if
  end function

  function real_to_rational_pow(ex,r1)
    integer, dimension(2), intent(in) :: r1
    real, intent(in) :: ex
    real :: real_to_rational_pow
    real_to_rational_pow = ex ** (real(r1(1)) / real(r1(2)))
  end function

  function reduce(r1)
    integer, dimension(2), intent(in) :: r1
    integer :: reduce(2), numerator, denominator, common_divisor

    numerator = r1(1)
    denominator = r1(2)
    if (denominator == 0) then
      reduce = [0, 1]
      return
    end if
    if (numerator == 0) then
      reduce = [0, 1]
      return
    end if
    common_divisor = gcd(abs(numerator), abs(denominator))
    numerator = numerator / common_divisor
    denominator = denominator / common_divisor
    if (denominator < 0) then
      numerator = -numerator
      denominator = -denominator
    end if
    reduce = [numerator, denominator]
  end function

  integer function gcd(a, b)
    integer, intent(in) :: a, b
    integer :: x, y, remainder
    x = a
    y = b
    do while (y /= 0)
      remainder = mod(x, y)
      x = y
      y = remainder
    end do
    gcd = x
  end function gcd

end module
