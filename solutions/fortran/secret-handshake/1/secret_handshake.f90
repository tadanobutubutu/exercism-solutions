module secret_handshake
  implicit none
contains

  function commands(number)
    integer, intent(in) :: number
    character(len=20), allocatable :: commands(:)
    character(len=20), parameter :: actions(4) = [character(len=20) :: &
      'wink', 'double blink', 'close your eyes', 'jump']
    integer :: action_count, action_index, output_index
    logical :: reverse_order

    action_count = 0
    do action_index = 0, 3
      if (btest(number, action_index)) action_count = action_count + 1
    end do
    allocate(commands(action_count))
    reverse_order = btest(number, 4)
    output_index = 0
    do action_index = 1, 4
      if (reverse_order) then
        if (.not. btest(number, 4 - action_index)) cycle
        output_index = output_index + 1
        commands(output_index) = actions(5 - action_index)
      else
        if (.not. btest(number, action_index - 1)) cycle
        output_index = output_index + 1
        commands(output_index) = actions(action_index)
      end if
    end do
  end function

end module
