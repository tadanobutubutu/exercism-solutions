
module matrix
  implicit none

contains

  function row(matrix, dims, i) result(r)
    integer, dimension(2), intent(in) :: dims
    !! Matrix dimensions (nrows, ncols)
    character(len=*), dimension(dims(1)), intent(in) :: matrix
    !! Matrix as a 1-d array of strings
    integer, intent(in) :: i
    !! Row index
    integer, dimension(dims(2)) :: r
    integer :: status
    read(matrix(i), *, iostat=status) r
    if (status /= 0) r = 0
  end function

  function column(matrix, dims, j) result(c)
    integer, dimension(2), intent(in) :: dims
    !! Matrix dimensions (nrows, ncols)
    character(len=*), dimension(dims(1)), intent(in) :: matrix
    !! Matrix as a 1-d array of strings
    integer, intent(in) :: j
    !! Column index
    integer, dimension(dims(1)) :: c
    integer :: i, status
    integer, dimension(dims(2)) :: parsed
    do i = 1, dims(1)
      read(matrix(i), *, iostat=status) parsed
      if (status == 0 .and. j >= 1 .and. j <= dims(2)) then
        c(i) = parsed(j)
      else
        c(i) = 0
      end if
    end do
  end function

end module
