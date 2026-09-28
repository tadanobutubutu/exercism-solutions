
module acronym
  implicit none
contains

  function abbreviate(s)
    character(len=*), intent(in) :: s
    character(len=len_trim(s)) :: abbreviate
    integer :: i, count
    logical :: at_word_start
    character :: ch

    count = 0
    at_word_start = .true.
    abbreviate = ' '
    do i = 1, len_trim(s)
      ch = s(i:i)
      if (ch == ' ' .or. ch == '-' .or. ch == '_') then
        at_word_start = .true.
      else
        if (at_word_start .and. is_letter(ch)) then
          count = count + 1
          if (ch >= 'a' .and. ch <= 'z') then
            abbreviate(count:count) = achar(iachar(ch) - iachar('a') + iachar('A'))
          else
            abbreviate(count:count) = ch
          end if
        end if
        at_word_start = .false.
      end if
    end do
  end function

  logical function is_letter(ch)
    character, intent(in) :: ch
    is_letter = (ch >= 'a' .and. ch <= 'z') .or. (ch >= 'A' .and. ch <= 'Z')
  end function

end module
