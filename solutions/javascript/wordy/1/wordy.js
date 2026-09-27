//
// This is only a SKELETON file for the 'Wordy' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const answer = question => {
  if (!question.startsWith('What is') || !question.endsWith('?')) {
    throw new Error('Unknown operation');
  }

  const tokens = question.slice(8, -1).trim().split(/\s+/).filter(Boolean);
  if (tokens.length === 0) throw new Error('Syntax error');

  const isNumber = token => /^-?\d+$/.test(token);
  const operations = {
    plus: (left, right) => left + right,
    minus: (left, right) => left - right,
    'multiplied by': (left, right) => left * right,
    'divided by': (left, right) => left / right,
  };
  const first = Number(tokens[0]);
  if (!isNumber(tokens[0])) {
    if (['plus', 'minus', 'multiplied', 'divided'].includes(tokens[0])) {
      throw new Error('Syntax error');
    }
    throw new Error('Unknown operation');
  }

  let result = first;
  let index = 1;
  while (index < tokens.length) {
    let operator;
    const token = tokens[index];
    if (token === 'multiplied' || token === 'divided') {
      if (tokens[index + 1] !== 'by') throw new Error('Syntax error');
      operator = `${token} by`;
      index += 2;
    } else if (token === 'plus' || token === 'minus') {
      operator = token;
      index += 1;
    } else if (isNumber(token)) {
      throw new Error('Syntax error');
    } else {
      throw new Error('Unknown operation');
    }

    if (index >= tokens.length || !isNumber(tokens[index])) {
      throw new Error('Syntax error');
    }
    result = operations[operator](result, Number(tokens[index]));
    index += 1;
  }

  return result;
};
