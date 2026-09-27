/**
 * This stub is provided to make it straightforward to get started.
 */

export function twoFer(name = 'you'): string {
  // ^                 ^   ^ this is called a return type; it's the type of the
  // ^                 ^     value that is returned from this function
  // ^                 ^
  // ^                 parameters go here
  // ^
  // allows the tests to import this function and call it
  return `One for ${name}, one for me.`
}
