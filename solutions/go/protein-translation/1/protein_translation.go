package proteintranslation

import "errors"

var (
	ErrStop        = errors.New("stop codon")
	ErrInvalidBase = errors.New("invalid base")
)

var proteins = map[string]string{
	"AUG": "Methionine",
	"UUU": "Phenylalanine", "UUC": "Phenylalanine",
	"UUA": "Leucine", "UUG": "Leucine",
	"UCU": "Serine", "UCC": "Serine", "UCA": "Serine", "UCG": "Serine",
	"UAU": "Tyrosine", "UAC": "Tyrosine",
	"UGU": "Cysteine", "UGC": "Cysteine",
	"UGG": "Tryptophan",
}

func FromRNA(rna string) ([]string, error) {
	result := make([]string, 0, len(rna)/3)
	for index := 0; index < len(rna); index += 3 {
		end := index + 3
		if end > len(rna) {
			end = len(rna)
		}
		protein, err := FromCodon(rna[index:end])
		if err == ErrStop {
			return result, nil
		}
		if err != nil {
			return nil, err
		}
		result = append(result, protein)
	}
	return result, nil
}

func FromCodon(codon string) (string, error) {
	if codon == "UAA" || codon == "UAG" || codon == "UGA" {
		return "", ErrStop
	}
	protein, ok := proteins[codon]
	if !ok {
		return "", ErrInvalidBase
	}
	return protein, nil
}
