export const proverb = (...args) => {
  const options = args.at(-1);
  const qualifier = options && typeof options === 'object' ? options.qualifier : undefined;
  const pieces = qualifier === undefined ? args : args.slice(0, -1);
  if (pieces.length === 0) return '';

  const lines = pieces.slice(0, -1).map(
    (piece, index) => `For want of a ${piece} the ${pieces[index + 1]} was lost.`,
  );
  lines.push(`And all for the want of a ${qualifier ? `${qualifier} ` : ''}${pieces[0]}.`);
  return lines.join('\n');
};
