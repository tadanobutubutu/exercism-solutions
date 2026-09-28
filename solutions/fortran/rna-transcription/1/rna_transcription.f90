module rna_transcription
  implicit none
contains

  function to_rna(dna)
      character(*), intent(in) :: dna
      character(len(dna)) :: to_rna
      integer :: i

      do i = 1, len(dna)
          select case (dna(i:i))
          case ('A')
              to_rna(i:i) = 'U'
          case ('C')
              to_rna(i:i) = 'G'
          case ('G')
              to_rna(i:i) = 'C'
          case ('T')
              to_rna(i:i) = 'A'
          case default
              to_rna(i:i) = dna(i:i)
          end select
      end do
  end function to_rna

end module rna_transcription
