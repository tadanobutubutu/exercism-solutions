module bob
  implicit none
contains

  function hey(statement)
    character(100) :: hey
    character(len=*), intent(in) :: statement
    integer :: i, last_nonspace, code
    logical :: has_letter, all_uppercase, is_question

    last_nonspace = 0
    has_letter = .false.
    all_uppercase = .true.
    do i = 1, len(statement)
      code = iachar(statement(i:i))
      if (code /= 9 .and. code /= 10 .and. code /= 11 .and. &
          code /= 12 .and. code /= 13 .and. code /= 32) then
        last_nonspace = i
      end if
      if ((code >= iachar('A') .and. code <= iachar('Z')) .or. &
          (code >= iachar('a') .and. code <= iachar('z'))) then
        has_letter = .true.
      end if
      if (code >= iachar('a') .and. code <= iachar('z')) all_uppercase = .false.
    end do

    if (last_nonspace == 0) then
      hey = "Fine. Be that way!"
      return
    end if

    is_question = statement(last_nonspace:last_nonspace) == '?'
    if (has_letter .and. all_uppercase) then
      if (is_question) then
        hey = "Calm down, I know what I'm doing!"
      else
        hey = "Whoa, chill out!"
      end if
    else if (is_question) then
      hey = "Sure."
    else
      hey = "Whatever."
    end if
  end function hey

end module bob
