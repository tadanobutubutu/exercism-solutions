import { randomBytes } from 'node:crypto'

const alphabet = 'abcdefghijklmnopqrstuvwxyz'

export class SimpleCipher {
  public readonly key: string

  constructor(key?: string) {
    this.key = key ?? Array.from(randomBytes(100), (byte) => alphabet[byte % 26]).join('')
    if (!/^[a-z]+$/.test(this.key)) throw new Error('Key must contain lowercase letters')
  }

  encode(plaintext: string): string {
    return [...plaintext]
      .map((letter, index) => {
        const plain = alphabet.indexOf(letter)
        const shift = alphabet.indexOf(this.key[index % this.key.length])
        return alphabet[(plain + shift) % alphabet.length]
      })
      .join('')
  }

  decode(ciphertext: string): string {
    return [...ciphertext]
      .map((letter, index) => {
        const encoded = alphabet.indexOf(letter)
        const shift = alphabet.indexOf(this.key[index % this.key.length])
        return alphabet[(encoded - shift + alphabet.length) % alphabet.length]
      })
      .join('')
  }
}
