
module high_scores
  implicit none
contains

function scores(score_list) result(all_scores)
  integer, dimension(:), intent(in) :: score_list
  integer :: all_scores(size(score_list))
  all_scores = score_list
end function scores

integer function latest(score_list)
  integer, dimension(:), intent(in) :: score_list
  latest = 0
  if (size(score_list) > 0) latest = score_list(size(score_list))
end function latest

integer function personalBest(score_list)
  integer, dimension(:), intent(in) :: score_list
  personalBest = 0
  if (size(score_list) > 0) personalBest = maxval(score_list)
end function personalBest

function personalTopThree(score_list) result(top_three)
  integer, dimension(:), intent(in) :: score_list
  integer :: top_three(3)
  integer, allocatable :: sorted_scores(:)
  integer :: i, j, limit, temporary

  top_three = 0
  if (size(score_list) == 0) return
  sorted_scores = score_list
  do i = 1, size(sorted_scores) - 1
    do j = i + 1, size(sorted_scores)
      if (sorted_scores(j) > sorted_scores(i)) then
        temporary = sorted_scores(i)
        sorted_scores(i) = sorted_scores(j)
        sorted_scores(j) = temporary
      end if
    end do
  end do
  limit = min(3, size(sorted_scores))
  top_three(1:limit) = sorted_scores(1:limit)

end function
  
end module
