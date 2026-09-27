package nucleotidecount

import "errors"

type Histogram map[rune]int
type DNA string

// Counts returns nucleotide totals or an error when the strand is invalid.
func (d DNA) Counts() (Histogram, error) {
	histogram := Histogram{'A': 0, 'C': 0, 'G': 0, 'T': 0}
	for _, nucleotide := range d {
		if _, valid := histogram[nucleotide]; !valid {
			return Histogram{}, errors.New("invalid nucleotide")
		}
		histogram[nucleotide]++
	}
	return histogram, nil
}
