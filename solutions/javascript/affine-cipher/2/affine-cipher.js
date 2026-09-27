const MODULUS = 26;
const gcd = (a, b) => (b === 0 ? Math.abs(a) : gcd(b, a % b));
const mod = (n, m) => ((n % m) + m) % m;

const validateKey = (a) => {
  if (gcd(a, MODULUS) !== 1) throw new Error('a and m must be coprime.');
};

const inverse = (a) => {
  for (let i = 1; i < MODULUS; i += 1) {
    if ((a * i) % MODULUS === 1) return i;
  }
  throw new Error('a and m must be coprime.');
};

export const encode = (phrase, { a, b }) => {
  validateKey(a);
  const encoded = phrase
    .toLowerCase()
    .replace(/[^a-z0-9]/g, '')
    .replace(/[a-z]/g, (letter) => {
      const value = letter.charCodeAt(0) - 97;
      return String.fromCharCode(97 + mod(a * value + b, MODULUS));
    });
  return encoded.match(/.{1,5}/g)?.join(' ') ?? '';
};

export const decode = (phrase, { a, b }) => {
  validateKey(a);
  const multiplier = inverse(a);
  return phrase
    .toLowerCase()
    .replace(/[^a-z0-9]/g, '')
    .replace(/[a-z]/g, (letter) => {
      const value = letter.charCodeAt(0) - 97;
      return String.fromCharCode(97 + mod(multiplier * (value - b), MODULUS));
    });
};
