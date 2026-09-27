//
// This is only a SKELETON file for the 'Run Length Encoding' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const encode = (input) =>
  input.replace(/(.)\1*/gs, (run, character) => `${run.length > 1 ? run.length : ''}${character}`);

export const decode = (input) =>
  input.replace(/(\d+)(.)/gs, (_, count, character) => character.repeat(Number(count)));
