module darts
  implicit none

contains

  function score(x, y) result(points)
    real, intent(in):: x, y
    integer :: points

    block
      real :: radius
      radius = sqrt(x * x + y * y)
      if (radius <= 1.0) then
        points = 10
      else if (radius <= 5.0) then
        points = 5
      else if (radius <= 10.0) then
        points = 1
      else
        points = 0
      end if
    end block
  end function score

end module darts
