
module triangle
  implicit none

  interface equilateral
    module procedure equilateral_real
    module procedure equilateral_int
  end interface

  interface scalene
    module procedure scalene_real
    module procedure scalene_int
  end interface

  interface isosceles
    module procedure isosceles_real
    module procedure isosceles_int
  end interface

 contains

  logical function equilateral_real(edges)
    real, dimension(3), intent(in) :: edges
    logical :: valid
    valid = all(edges > 0.0) .and. edges(1) + edges(2) > edges(3) .and. &
            edges(1) + edges(3) > edges(2) .and. edges(2) + edges(3) > edges(1)
    equilateral_real = valid .and. all(edges == edges(1))
  end function

  logical function equilateral_int(edges)
    integer, dimension(3), intent(in) :: edges
    integer(kind=8) :: a, b, c
    logical :: valid
    a = int(edges(1), kind=8); b = int(edges(2), kind=8); c = int(edges(3), kind=8)
    valid = all(edges > 0) .and. a + b > c .and. a + c > b .and. b + c > a
    equilateral_int = valid .and. all(edges == edges(1))
  end function

  logical function isosceles_real(edges)
    real, dimension(3), intent(in) :: edges
    logical :: valid
    valid = all(edges > 0.0) .and. edges(1) + edges(2) > edges(3) .and. &
            edges(1) + edges(3) > edges(2) .and. edges(2) + edges(3) > edges(1)
    isosceles_real = valid .and. (edges(1) == edges(2) .or. &
                                  edges(1) == edges(3) .or. edges(2) == edges(3))
  end function

  logical function isosceles_int(edges)
    integer, dimension(3), intent(in) :: edges
    integer(kind=8) :: a, b, c
    logical :: valid
    a = int(edges(1), kind=8); b = int(edges(2), kind=8); c = int(edges(3), kind=8)
    valid = all(edges > 0) .and. a + b > c .and. a + c > b .and. b + c > a
    isosceles_int = valid .and. (edges(1) == edges(2) .or. &
                                 edges(1) == edges(3) .or. edges(2) == edges(3))
  end function


  logical function scalene_real(edges)
    real, dimension(3), intent(in) :: edges
    logical :: valid
    valid = all(edges > 0.0) .and. edges(1) + edges(2) > edges(3) .and. &
            edges(1) + edges(3) > edges(2) .and. edges(2) + edges(3) > edges(1)
    scalene_real = valid .and. edges(1) /= edges(2) .and. &
                   edges(1) /= edges(3) .and. edges(2) /= edges(3)
  end function

  logical function scalene_int(edges)
    integer, dimension(3), intent(in) :: edges
    integer(kind=8) :: a, b, c
    logical :: valid
    a = int(edges(1), kind=8); b = int(edges(2), kind=8); c = int(edges(3), kind=8)
    valid = all(edges > 0) .and. a + b > c .and. a + c > b .and. b + c > a
    scalene_int = valid .and. edges(1) /= edges(2) .and. &
                  edges(1) /= edges(3) .and. edges(2) /= edges(3)
  end function

end module
