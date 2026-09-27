//
// This is only a SKELETON file for the 'Variable Length Quantity' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const encode = values => {
  const encoded = [];
  for (const value of values) {
    if (!Number.isInteger(value) || value < 0 || value > 0xffffffff) {
      throw new RangeError('values must be unsigned 32-bit integers');
    }
    const chunks = [];
    let remaining = value;
    do {
      chunks.push(remaining % 0x80);
      remaining = Math.floor(remaining / 0x80);
    } while (remaining > 0);
    chunks.reverse();
    for (let index = 0; index < chunks.length; index += 1) {
      encoded.push(index < chunks.length - 1 ? chunks[index] | 0x80 : chunks[index]);
    }
  }
  return encoded;
};

export const decode = bytes => {
  const decoded = [];
  let value = 0;
  let incomplete = false;
  for (const byte of bytes) {
    value = value * 0x80 + (byte & 0x7f);
    incomplete = (byte & 0x80) !== 0;
    if (!incomplete) {
      decoded.push(value);
      value = 0;
    }
  }
  if (incomplete) throw new Error('Incomplete sequence');
  return decoded;
};
