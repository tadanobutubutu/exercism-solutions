export class Crypto {
  constructor(text) {
    this._normalized = text.toLowerCase().replace(/[^a-z0-9]/g, '');
  }

  get ciphertext() {
    if (this._normalized === '') return '';
    const len = this._normalized.length;
    const cols = Math.ceil(Math.sqrt(len));
    const rows = Math.ceil(len / cols);
    const result = [];
    for (let c = 0; c < cols; c++) {
      let chunk = '';
      for (let r = 0; r < rows; r++) {
        const idx = r * cols + c;
        chunk += idx < len ? this._normalized[idx] : ' ';
      }
      result.push(chunk);
    }
    return result.join(' ');
  }
}
