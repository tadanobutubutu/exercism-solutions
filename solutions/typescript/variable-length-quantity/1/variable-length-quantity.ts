export function encode(values: number[]): number[] {
  const output: number[] = []
  for (const value of values) {
    if (!Number.isSafeInteger(value) || value < 0 || value > 0xffffffff) {
      throw new RangeError('values must be unsigned 32-bit integers')
    }

    const chunks = [value % 0x80]
    let remaining = Math.floor(value / 0x80)
    while (remaining > 0) {
      chunks.push(remaining % 0x80)
      remaining = Math.floor(remaining / 0x80)
    }
    chunks.reverse()
    for (let index = 0; index < chunks.length; index++) {
      output.push(chunks[index] | (index < chunks.length - 1 ? 0x80 : 0))
    }
  }
  return output
}

export function decode(bytes: number[]): number[] {
  const values: number[] = []
  let value = 0
  let incomplete = false

  for (const byte of bytes) {
    if (!Number.isInteger(byte) || byte < 0 || byte > 0xff) {
      throw new RangeError('bytes must be unsigned 8-bit integers')
    }
    value = value * 0x80 + (byte & 0x7f)
    incomplete = (byte & 0x80) !== 0
    if (!incomplete) {
      values.push(value)
      value = 0
    }
  }

  if (incomplete) throw new Error('Incomplete sequence')
  return values
}
