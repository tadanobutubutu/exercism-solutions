function isPrime(n) {
  if (n < 2) return false;
  for (let i = 2; i * i <= n; i++) {
    if (n % i === 0) return false;
  }
  return true;
}

function modPow(base, exp, mod) {
  let result = 1n;
  base = BigInt(base) % BigInt(mod);
  let e = BigInt(exp);
  const m = BigInt(mod);
  while (e > 0n) {
    if (e % 2n === 1n) {
      result = (result * base) % m;
    }
    e >>= 1n;
    base = (base * base) % m;
  }
  return Number(result);
}

export class DiffieHellman {
  constructor(p, g) {
    if (!isPrime(p) || !isPrime(g)) {
      throw new Error('p and g must be prime');
    }
    this.p = p;
    this.g = g;
  }

  getPublicKey(privateKey) {
    if (privateKey <= 1 || privateKey >= this.p) {
      throw new Error('invalid private key');
    }
    return modPow(this.g, privateKey, this.p);
  }

  getSecret(theirPublicKey, myPrivateKey) {
    return modPow(theirPublicKey, myPrivateKey, this.p);
  }

  static getPrivateKey(p) {
    return Math.floor(Math.random() * (p - 2)) + 2;
  }
}
