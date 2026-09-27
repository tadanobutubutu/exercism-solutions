package intergalactictransmission

import (
	"errors"
	"math/bits"
)

var errWrongParity = errors.New("wrong parity")

func Transmit(message []byte) []byte {
	transmission := make([]byte, 0, (len(message)*8+6)/7)
	var data byte
	bitsInByte := 0
	for _, value := range message {
		for bit := 7; bit >= 0; bit-- {
			if value&(1<<bit) != 0 {
				data |= 1 << (7 - bitsInByte)
			}
			bitsInByte++
			if bitsInByte == 7 {
				transmission = append(transmission, data|byte(bits.OnesCount8(data)&1))
				data, bitsInByte = 0, 0
			}
		}
	}
	if bitsInByte > 0 {
		transmission = append(transmission, data|byte(bits.OnesCount8(data)&1))
	}
	return transmission
}

func Decode(message []byte) ([]byte, error) {
	dataBits := make([]byte, 0, len(message)*7)
	for _, value := range message {
		if bits.OnesCount8(value)&1 != 0 {
			return []byte{}, errWrongParity
		}
		for bit := 7; bit >= 1; bit-- {
			dataBits = append(dataBits, (value>>bit)&1)
		}
	}

	decoded := make([]byte, 0, len(dataBits)/8)
	for i := 0; i+8 <= len(dataBits); i += 8 {
		var value byte
		for _, bit := range dataBits[i : i+8] {
			value = value<<1 | bit
		}
		decoded = append(decoded, value)
	}
	return decoded, nil
}
