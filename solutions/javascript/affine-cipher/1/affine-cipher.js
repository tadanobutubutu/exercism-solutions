function gcd(a, b) {
  while (b !== 0) {
    [a, b] = [b, a % b];
  }
  return a;
}

function modInverse(a, m) {
  for (let x = 1; x < m; x++) {
    if ((a * x) % m === 1) return x;
  }
  return -1;
}

function process(text, key, mode) {
  const m = 26;
  if (gcd(key.a, m) !== 1) throw new Error('a and m must be coprime.');

  const aInv = modInverse(key.a % m, m);
  const cleaned = text.toLowerCase().replace(/[^a-z0-9]/g, '');

  let result = '';
  for (const char of cleaned) {
    if (/[a-z]/.test(char)) {
      const x = char.charCodeAt(0) - 97;
      let y;
      if (mode === 'encode') {
        y = (key.a * x + key.b) % m;
      } else {
        y = (aInv * (((x - key.b) % m + m) % m)) % m;
      }
      result += String.fromCharCode(y + 97);
    } else {
      result += char;
    }
  }

  if (mode === 'encode') {
    const chunks = [];
    for (let i = 0; i < result.length; i += 5) {
      chunks.push(result.slice(i, i + 5));
    }
    return chunks.join(' ');
  }
  return result;
}

export const encode = (text, key) => process(text, key, 'encode');
export const decode = (text, key) => process(text, key, 'decode');
