export class Crypto {
  private readonly normalized: string

  constructor(plainText: unknown) {
    this.normalized =
      typeof plainText === 'string'
        ? plainText.toLowerCase().replace(/[^a-z0-9]/g, '')
        : ''
  }

  get ciphertext(): string {
    const length = this.normalized.length
    if (length === 0) return ''

    let columns = 1
    let rows = 1
    for (; columns <= length; columns++) {
      const possibleRows = columns === 1 ? [1] : [columns - 1, columns]
      const fittingRows = possibleRows.find((candidate) => candidate * columns >= length)
      if (fittingRows !== undefined) {
        rows = fittingRows
        break
      }
    }

    const chunks: string[] = []
    for (let column = 0; column < columns; column++) {
      let chunk = ''
      for (let row = 0; row < rows; row++) {
        const index = row * columns + column
        chunk += index < length ? this.normalized[index] : ' '
      }
      chunks.push(chunk)
    }
    return chunks.join(' ')
  }
}
