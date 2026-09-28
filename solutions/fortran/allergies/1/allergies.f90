
module allergies
  implicit none

contains

  logical function allergicTo(allergy_str, allergy_key)
    character(len=*), intent(in) :: allergy_str
    integer, intent(in) :: allergy_key
    integer :: bit_index
    select case (trim(allergy_str))
    case ('eggs')
      bit_index = 0
    case ('peanuts')
      bit_index = 1
    case ('shellfish')
      bit_index = 2
    case ('strawberries')
      bit_index = 3
    case ('tomatoes')
      bit_index = 4
    case ('chocolate')
      bit_index = 5
    case ('pollen')
      bit_index = 6
    case ('cats')
      bit_index = 7
    case default
      allergicTo = .false.
      return
    end select
    allergicTo = btest(allergy_key, bit_index)
  end function


  function allergicList(allergy_key)
    integer, intent(in) :: allergy_key
    character(len=100) :: allergicList
    character(12), parameter :: allergens(8) = [character(12) :: &
      'eggs', 'peanuts', 'shellfish', 'strawberries', &
      'tomatoes', 'chocolate', 'pollen', 'cats']
    integer :: i, position, name_length

    allergicList = ''
    position = 1
    do i = 1, size(allergens)
      if (.not. btest(allergy_key, i - 1)) cycle
      name_length = len_trim(allergens(i))
      if (position > 1) then
        allergicList(position:position) = ' '
        position = position + 1
      end if
      allergicList(position:position + name_length - 1) = allergens(i)(1:name_length)
      position = position + name_length
    end do
  end function



end module
