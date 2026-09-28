module line_up
  implicit none
contains

  function lineUp(name, number)
    character(len=*), intent(in) :: name
    integer, intent(in) :: number
    character(len=:), allocatable :: lineUp

    character(30) :: number_text
    character(2) :: suffix
    integer :: last_two, last_digit

    write(number_text, '(i0)') number
    last_two = modulo(number, 100)
    last_digit = modulo(number, 10)
    if (last_two >= 11 .and. last_two <= 13) then
      suffix = 'th'
    else
      select case (last_digit)
      case (1)
        suffix = 'st'
      case (2)
        suffix = 'nd'
      case (3)
        suffix = 'rd'
      case default
        suffix = 'th'
      end select
    end if
    lineUp = trim(name) // ', you are the ' // trim(number_text) // suffix // &
             ' customer we serve today. Thank you!'

  end function

end module
