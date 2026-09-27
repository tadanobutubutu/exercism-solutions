//
// This is only a SKELETON file for the 'Simple Cipher' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Cipher {
  constructor(key = undefined) {
    this._key = key ?? Array.from({ length: 100 }, () =>
      String.fromCharCode(97 + Math.floor(Math.random() * 26))).join('');
  }

  encode(text) {
    return [...text].map((character, index) => {
      const plain = character.charCodeAt(0) - 97;
      const shift = this._key.charCodeAt(index % this._key.length) - 97;
      return String.fromCharCode(97 + (plain + shift) % 26);
    }).join('');
  }

  decode(text) {
    return [...text].map((character, index) => {
      const encoded = character.charCodeAt(0) - 97;
      const shift = this._key.charCodeAt(index % this._key.length) - 97;
      return String.fromCharCode(97 + (encoded - shift + 26) % 26);
    }).join('');
  }

  get key() {
    return this._key;
  }
}
