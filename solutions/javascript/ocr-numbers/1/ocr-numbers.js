const DIGITS = {
  ' _ | ||_|': '0',
  '     |  |': '1',
  ' _  _||_ ': '2',
  ' _  _| _|': '3',
  '   |_|  |': '4',
  ' _ |_  _|': '5',
  ' _ |_ |_|': '6',
  ' _   |  |': '7',
  ' _ |_||_|': '8',
  ' _ |_| _|': '9',
};

export const convert = (input) => {
  const rows = input.split('\n');
  const result = [];
  for (let i = 0; i < rows.length; i += 4) {
    const chunk = rows.slice(i, i + 4);
    let line = '';
    for (let c = 0; c < chunk[0].length; c += 3) {
      const pattern =
        chunk[0].slice(c, c + 3) +
        chunk[1].slice(c, c + 3) +
        chunk[2].slice(c, c + 3);
      line += DIGITS[pattern] || '?';
    }
    result.push(line);
  }
  return result.join(',');
};
