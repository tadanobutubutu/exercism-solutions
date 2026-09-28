module roman_numerals
  implicit none

contains

  function roman(num) result(s)
    integer, value :: num
    character(15) :: s
    integer, parameter :: values(13) = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
    character(2), parameter :: symbols(13) = [character(2) :: 'M ', 'CM', 'D ', 'CD', 'C ', &
                                               'XC', 'L ', 'XL', 'X ', 'IX', 'V ', 'IV', 'I ']
    integer :: i, position, remaining, repeats, symbol_length

    s = ''
    remaining = num
    position = 1
    do i = 1, size(values)
      repeats = remaining / values(i)
      if (repeats <= 0) cycle
      symbol_length = len_trim(symbols(i))
      do while (repeats > 0 .and. position + symbol_length - 1 <= len(s))
        s(position:position + symbol_length - 1) = symbols(i)(1:symbol_length)
        position = position + symbol_length
        remaining = remaining - values(i)
        repeats = repeats - 1
      end do
    end do
  end function roman

end module roman_numerals
