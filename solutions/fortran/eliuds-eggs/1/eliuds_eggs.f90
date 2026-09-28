module eliuds_eggs

  implicit none

contains

  integer function eggCount(number)
    integer, intent(in) :: number

    if (number < 0) then
      eggCount = 0
    else
      eggCount = popcnt(number)
    end if
  end function

end module
