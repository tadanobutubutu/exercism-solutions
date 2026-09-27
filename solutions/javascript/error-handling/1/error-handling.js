//
// This is only a SKELETON file for the 'Error handling' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const processString = (input) => {
  try {
    if (typeof input !== 'string') throw new TypeError('Input must be a string.');
    if (input === '') return null;
    if (input.length < 10 || input.length > 100) {
      throw new RangeError('Input length must be between 10 and 100 characters.');
    }
    if (/[a-z]/i.test(input) && /\d/.test(input)) {
      throw new SyntaxError('Input cannot contain both letters and numbers.');
    }
    return input.toUpperCase();
  } catch (error) {
    console.log(error.message);
    throw error;
  }
};
