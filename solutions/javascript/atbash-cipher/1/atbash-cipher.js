function atbashChar(c) {
  const code = c.charCodeAt(0);
  return String.fromCharCode(219 - code);
}

function atbash(str) {
  return str.replace(/[a-z]/g, atbashChar);
}

export const encode = (text) => {
  const cleaned = text.toLowerCase().replace(/[^a-z0-9]/g, '');
  const encoded = atbash(cleaned);
  const chunks = [];
  for (let i = 0; i < encoded.length; i += 5) {
    chunks.push(encoded.slice(i, i + 5));
  }
  return chunks.join(' ');
};

export const decode = (text) => {
  const cleaned = text.replace(/\s/g, '');
  return atbash(cleaned);
};
