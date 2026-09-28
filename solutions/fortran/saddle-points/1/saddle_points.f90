module saddle_points
  implicit none

  type :: point_t
    integer :: row
    integer :: column
  end type point_t

contains

  function saddlePoints(matrix) result(points)
    integer, intent(in) :: matrix(:, :)
    type(point_t), allocatable :: points(:)
    integer :: row_idx, column_idx, count, row_max, column_min

    count = 0
    do row_idx = 1, size(matrix, 1)
      row_max = maxval(matrix(row_idx, :))
      do column_idx = 1, size(matrix, 2)
        column_min = minval(matrix(:, column_idx))
        if (matrix(row_idx, column_idx) == row_max .and. &
            matrix(row_idx, column_idx) == column_min) count = count + 1
      end do
    end do

    allocate(points(count))
    count = 0
    do row_idx = 1, size(matrix, 1)
      row_max = maxval(matrix(row_idx, :))
      do column_idx = 1, size(matrix, 2)
        column_min = minval(matrix(:, column_idx))
        if (matrix(row_idx, column_idx) == row_max .and. &
            matrix(row_idx, column_idx) == column_min) then
          count = count + 1
          points(count) = point_t(row=row_idx, column=column_idx)
        end if
      end do
    end do
  end function saddlePoints

end module saddle_points
