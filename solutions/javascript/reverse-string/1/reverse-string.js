export const reverseString = (text) => {
  const segmenter = new Intl.Segmenter(undefined, { granularity: 'grapheme' });
  return Array.from(segmenter.segment(text), ({ segment }) => segment)
    .reverse()
    .join('');
};
