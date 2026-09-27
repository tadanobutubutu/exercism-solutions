export class DiffieHellman {
  private readonly p: number
  private readonly g: number

  constructor(p: unknown, g: unknown) {
    if (
      typeof p !== 'number' ||
      !Number.isSafeInteger(p) ||
      p < 2 ||
      typeof g !== 'number' ||
      !Number.isSafeInteger(g) ||
      g <= 1 ||
      g >= p ||
      !this.isPrime(p)
    ) {
      throw new Error('invalid prime or generator')
    }
    this.p = p
    this.g = g
  }

  public getPublicKey(privateKey: unknown): number {
    if (!this.isPrivateKey(privateKey)) throw new Error('invalid private key')
    return this.modularPower(this.g, privateKey, this.p)
  }

  public getSecret(theirPublicKey: unknown, myPrivateKey: unknown): number {
    if (
      typeof theirPublicKey !== 'number' ||
      !Number.isSafeInteger(theirPublicKey) ||
      theirPublicKey < 1 ||
      theirPublicKey >= this.p ||
      !this.isPrivateKey(myPrivateKey)
    ) {
      throw new Error('invalid public or private key')
    }
    return this.modularPower(theirPublicKey, myPrivateKey, this.p)
  }

  private isPrivateKey(value: unknown): value is number {
    return (
      typeof value === 'number' &&
      Number.isSafeInteger(value) &&
      value > 1 &&
      value < this.p
    )
  }

  private isPrime(number: number): boolean {
    if (number < 2) return false
    if (number % 2 === 0) return number === 2
    for (let divisor = 3; divisor <= Math.sqrt(number); divisor += 2) {
      if (number % divisor === 0) return false
    }
    return true
  }

  private modularPower(base: number, exponent: number, modulus: number): number {
    let result = 1n
    let factor = BigInt(base) % BigInt(modulus)
    let power = BigInt(exponent)
    const mod = BigInt(modulus)

    while (power > 0n) {
      if (power % 2n === 1n) result = (result * factor) % mod
      factor = (factor * factor) % mod
      power /= 2n
    }
    return Number(result)
  }
}
