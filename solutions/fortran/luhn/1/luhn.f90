module luhn
  implicit none

contains

  function validate(number) result(valid)
    character(*), intent(in) :: number
    logical :: valid
    integer :: i, code, digit, position, total, digit_count

    valid = .false.
    total = 0
    digit_count = 0
    position = 0
    do i = len(number), 1, -1
      if (number(i:i) == ' ') cycle
      code = iachar(number(i:i))
      if (code < iachar('0') .or. code > iachar('9')) return
      digit = code - iachar('0')
      position = position + 1
      digit_count = digit_count + 1
      if (mod(position, 2) == 0) then
        digit = digit * 2
        if (digit > 9) digit = digit - 9
      end if
      total = total + digit
    end do
    if (digit_count < 2) return
    valid = mod(total, 10) == 0
  end function validate

end module luhn
