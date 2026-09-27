package variablelengthquantity

import "errors"

var errInvalidEncoding = errors.New("invalid variable-length quantity encoding")

func EncodeVarint(input []uint32) []byte {
	encoded := make([]byte, 0, len(input))
	for _, value := range input {
		groups := [5]byte{}
		last := len(groups) - 1
		groups[last] = byte(value & 0x7f)
		for value >>= 7; value > 0; value >>= 7 {
			last--
			groups[last] = byte(value&0x7f) | 0x80
		}
		encoded = append(encoded, groups[last:]...)
	}
	return encoded
}

func DecodeVarint(input []byte) ([]uint32, error) {
	decoded := make([]uint32, 0)
	var value uint32
	groups := 0

	for _, current := range input {
		if groups == 5 || value > ^uint32(0)>>7 {
			return nil, errInvalidEncoding
		}
		payload := uint32(current & 0x7f)
		if groups == 4 && payload > 0x0f {
			return nil, errInvalidEncoding
		}
		value = value<<7 | payload
		groups++

		if current&0x80 == 0 {
			decoded = append(decoded, value)
			value = 0
			groups = 0
		}
	}
	if groups != 0 {
		return nil, errInvalidEncoding
	}
	return decoded, nil
}
