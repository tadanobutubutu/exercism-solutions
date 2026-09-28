module pangram
  implicit none
contains

  logical function is_pangram(sentence)
    character(*), intent(in) :: sentence
    logical :: seen(26)
    integer :: i, code, letter

    seen = .false.
    do i = 1, len(sentence)
      code = iachar(sentence(i:i))
      if (code >= iachar('A') .and. code <= iachar('Z')) then
        letter = code - iachar('A') + 1
        seen(letter) = .true.
      else if (code >= iachar('a') .and. code <= iachar('z')) then
        letter = code - iachar('a') + 1
        seen(letter) = .true.
      end if
    end do
    is_pangram = all(seen)
  end function is_pangram

end module pangram
