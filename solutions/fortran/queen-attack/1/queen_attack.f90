
module queen_attack
  implicit none
contains

  logical function isValid(pos)
    integer, dimension(2), intent(in) :: pos
    isValid = all(pos >= 1) .and. all(pos <= 8)
  end function

  logical function canAttack(white_pos, black_pos)
    integer, dimension(2), intent(in) :: white_pos, black_pos
    canAttack = .false.
    if (.not. isValid(white_pos) .or. .not. isValid(black_pos)) return
    if (all(white_pos == black_pos)) return
    canAttack = white_pos(1) == black_pos(1) .or. &
                white_pos(2) == black_pos(2) .or. &
                abs(white_pos(1) - black_pos(1)) == abs(white_pos(2) - black_pos(2))
  end function

end module
