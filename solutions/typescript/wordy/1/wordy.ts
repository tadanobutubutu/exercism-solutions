export const answer = (question: string): number => {
  if (!question.startsWith('What is') || !question.endsWith('?')) {
    throw new Error('Unknown operation')
  }

  const expression = question.slice(7, -1).trim()
  if (!expression) throw new Error('Syntax error')

  const tokens = expression.match(/-?\d+|[a-zA-Z]+/g) ?? []
  if (tokens.join('') !== expression.replace(/\s+/g, '')) {
    throw new Error('Syntax error')
  }
  const first = tokens[0]
  if (first === undefined || !/^-?\d+$/.test(first)) throw new Error('Syntax error')

  let result = Number(first)
  let index = 1
  while (index < tokens.length) {
    const operation = tokens[index]
    if (operation === undefined) throw new Error('Syntax error')
    let operandIndex = index + 1
    if (operation === 'multiplied' || operation === 'divided') {
      if (tokens[operandIndex] !== 'by') throw new Error('Unknown operation')
      operandIndex++
    } else if (!['plus', 'minus'].includes(operation)) {
      if (/^-?\d+$/.test(operation)) throw new Error('Syntax error')
      throw new Error('Unknown operation')
    }

    const operand = tokens[operandIndex]
    if (operand === undefined || !/^-?\d+$/.test(operand)) {
      throw new Error('Syntax error')
    }
    const value = Number(operand)
    switch (operation) {
      case 'plus': result += value; break
      case 'minus': result -= value; break
      case 'multiplied': result *= value; break
      case 'divided': result /= value; break
    }
    index = operandIndex + 1
  }
  return result
}
