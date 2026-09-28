module largest_series_product

  implicit none
contains

  integer function largestProduct(strDigits, span)
    character(len=*), intent(in) :: strDigits
    integer, intent(in) :: span

    integer :: i, j, n, product, digit, code

    largestProduct = -1
    n = len(strDigits)
    if (span < 0 .or. span > n) return
    do i = 1, n
      code = iachar(strDigits(i:i))
      if (code < iachar('0') .or. code > iachar('9')) return
    end do
    if (span == 0) then
      largestProduct = 1
      return
    end if

    largestProduct = 0
    do i = 1, n - span + 1
      product = 1
      do j = 0, span - 1
        digit = iachar(strDigits(i + j:i + j)) - iachar('0')
        product = product * digit
      end do
      largestProduct = max(largestProduct, product)
    end do
  end function

end module
