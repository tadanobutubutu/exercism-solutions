module isbn_verifier
  implicit none

contains

  function isValid(isbn) result(valid)
    character(*), intent(in) :: isbn
    logical :: valid
    character(10) :: digits
    integer :: i, count, value, total, code

    digits = ' '
    count = 0
    valid = .false.
    do i = 1, len(isbn)
      if (isbn(i:i) == '-') cycle
      count = count + 1
      if (count > 10) return
      digits(count:count) = isbn(i:i)
    end do
    if (count /= 10) return

    total = 0
    do i = 1, 9
      code = iachar(digits(i:i))
      if (code < iachar('0') .or. code > iachar('9')) return
      value = code - iachar('0')
      total = total + (11 - i) * value
    end do

    if (digits(10:10) == 'X') then
      value = 10
    else
      code = iachar(digits(10:10))
      if (code < iachar('0') .or. code > iachar('9')) return
      value = code - iachar('0')
    end if
    total = total + value
    valid = mod(total, 11) == 0
  end function isValid

end module isbn_verifier
