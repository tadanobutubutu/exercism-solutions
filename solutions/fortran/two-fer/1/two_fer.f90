module two_fer
  implicit none

contains

  function twoFer(name) result(phrase)
    character(*), intent(in), optional :: name
    character(:), allocatable :: phrase

    character(:), allocatable :: chosen_name
    if (present(name)) then
      chosen_name = trim(name)
    else
      chosen_name = 'you'
    end if
    phrase = 'One for ' // chosen_name // ', one for me.'
  end function twoFer

end module two_fer
