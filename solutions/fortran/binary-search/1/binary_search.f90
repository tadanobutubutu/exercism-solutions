module binary_search
  implicit none
contains

  function find(array, val) result(idx)
    integer, dimension(:), intent(in) :: array
    integer, intent(in) :: val
    integer :: idx
    integer :: left, right, middle

    left = 1
    right = size(array)
    idx = -1
    do while (left <= right)
      middle = left + (right - left) / 2
      if (array(middle) == val) then
        idx = middle
        return
      else if (array(middle) < val) then
        left = middle + 1
      else
        right = middle - 1
      end if
    end do
  end function

end module
