module raindrops
  implicit none
contains

  function convert(i)
    integer, intent(in) :: i
    character(20) :: convert

    convert = ''
    if (mod(i, 3) == 0) convert = trim(convert) // 'Pling'
    if (mod(i, 5) == 0) convert = trim(convert) // 'Plang'
    if (mod(i, 7) == 0) convert = trim(convert) // 'Plong'
    if (len_trim(convert) == 0) write(convert, '(i0)') i
  end function convert

end module raindrops
