module protein_translation
  implicit none

contains

  function proteins(rna) result(names)
    character(len=*), intent(in) :: rna
    character(len=13), allocatable :: names(:)
    character(len=13), allocatable :: translated(:)
    character(len=13) :: protein
    integer :: start, count_proteins, codon_count

    codon_count = len(rna) / 3
    allocate(translated(codon_count))
    count_proteins = 0
    do start = 1, len(rna) - 2, 3
      protein = translate_codon(rna(start:start + 2))
      if (len_trim(protein) == 0) exit
      count_proteins = count_proteins + 1
      translated(count_proteins) = protein
    end do
    allocate(names(count_proteins))
    if (count_proteins > 0) names = translated(1:count_proteins)
  end function proteins

  function translate_codon(codon) result(protein)
    character(len=3), intent(in) :: codon
    character(len=13) :: protein
    select case (codon)
    case ('AUG')
      protein = 'Methionine'
    case ('UUU', 'UUC')
      protein = 'Phenylalanine'
    case ('UUA', 'UUG')
      protein = 'Leucine'
    case ('UCU', 'UCC', 'UCA', 'UCG')
      protein = 'Serine'
    case ('UAU', 'UAC')
      protein = 'Tyrosine'
    case ('UGU', 'UGC')
      protein = 'Cysteine'
    case ('UGG')
      protein = 'Tryptophan'
    case default
      protein = ''
    end select
  end function translate_codon

end module protein_translation
