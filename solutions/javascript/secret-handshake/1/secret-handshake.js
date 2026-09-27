const actions = ['wink', 'double blink', 'close your eyes', 'jump'];

export const commands = (number) => {
  const result = actions.filter((_, index) => number & (1 << index));
  return number & 16 ? result.reverse() : result;
};
