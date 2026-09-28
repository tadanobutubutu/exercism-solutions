module reverse_string
  implicit none
contains

  function reverse(input) result(reversed)
    character(*), intent(in) :: input
    character(len=len(input)) :: reversed

    integer :: i, n
    n = len(input)
    do i = 1, n
      reversed(i:i) = input(n - i + 1:n - i + 1)
    end do
  end function

end module
