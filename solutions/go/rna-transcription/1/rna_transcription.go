package rnatranscription

import "strings"

func ToRNA(dna string) string {
	var rna strings.Builder
	rna.Grow(len(dna))
	for _, nucleotide := range dna {
		switch nucleotide {
		case 'G':
			rna.WriteByte('C')
		case 'C':
			rna.WriteByte('G')
		case 'T':
			rna.WriteByte('A')
		case 'A':
			rna.WriteByte('U')
		}
	}
	return rna.String()
}
