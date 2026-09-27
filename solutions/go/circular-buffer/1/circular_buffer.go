package circularbuffer

import (
	"errors"
)

// Implement a circular buffer of bytes supporting both overflow-checked writes
// and unconditional, possibly overwriting, writes.
//
// We chose the provided API so that Buffer implements io.ByteReader
// and io.ByteWriter and can be used (size permitting) as a drop in
// replacement for anything using that interface.

type Buffer struct {
	data    []byte
	readPos int
	length  int
}

var (
	errBufferEmpty = errors.New("buffer empty")
	errBufferFull  = errors.New("buffer full")
)

func NewBuffer(size int) *Buffer {
	if size < 0 {
		size = 0
	}
	return &Buffer{data: make([]byte, size)}
}

func (b *Buffer) ReadByte() (byte, error) {
	if b.length == 0 {
		return 0, errBufferEmpty
	}
	value := b.data[b.readPos]
	b.readPos = (b.readPos + 1) % len(b.data)
	b.length--
	return value, nil
}

func (b *Buffer) WriteByte(c byte) error {
	if b.length == len(b.data) {
		return errBufferFull
	}
	writePos := (b.readPos + b.length) % len(b.data)
	b.data[writePos] = c
	b.length++
	return nil
}

func (b *Buffer) Overwrite(c byte) {
	if len(b.data) == 0 {
		return
	}
	if b.length == len(b.data) {
		b.data[b.readPos] = c
		b.readPos = (b.readPos + 1) % len(b.data)
		return
	}
	writePos := (b.readPos + b.length) % len(b.data)
	b.data[writePos] = c
	b.length++
}

func (b *Buffer) Reset() {
	b.readPos = 0
	b.length = 0
}
