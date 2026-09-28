module isogram
  implicit none

contains

  function isIsogram(phrase) result(no_repeats)
    character(len=*), intent(in) :: phrase
    logical :: no_repeats
    logical :: seen(26)
    integer :: i, code, letter

    seen = .false.
    no_repeats = .true.
    do i = 1, len(phrase)
      code = iachar(phrase(i:i))
      if (code >= iachar('A') .and. code <= iachar('Z')) then
        letter = code - iachar('A') + 1
      else if (code >= iachar('a') .and. code <= iachar('z')) then
        letter = code - iachar('a') + 1
      else
        cycle
      end if
      if (seen(letter)) then
        no_repeats = .false.
        return
      end if
      seen(letter) = .true.
    end do
  end function isIsogram

end module isogram
