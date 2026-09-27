//
// This is only a SKELETON file for the 'Palindrome Products' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Palindromes {
  static generate({ minFactor, maxFactor }) {
    let results;
    const calculate = () => {
      if (minFactor > maxFactor) throw new Error('min must be <= max');
      if (results) return results;

      const isPalindrome = value => {
        const digits = String(value);
        return digits === [...digits].reverse().join('');
      };

      let smallestValue = Infinity;
      let smallestFactors = [];
      for (let a = minFactor; a <= maxFactor; a += 1) {
        if (a * a > smallestValue) break;
        for (let b = a; b <= maxFactor; b += 1) {
          const product = a * b;
          if (product > smallestValue) break;
          if (product === smallestValue) {
            smallestFactors.push([a, b]);
            break;
          }
          if (!isPalindrome(product)) continue;
          if (product < smallestValue) {
            smallestValue = product;
            smallestFactors = [[a, b]];
          } else {
            smallestFactors.push([a, b]);
          }
        }
      }

      let largestValue = -Infinity;
      let largestFactors = [];
      for (let a = maxFactor; a >= minFactor; a -= 1) {
        if (a * maxFactor < largestValue) break;
        for (let b = maxFactor; b >= a; b -= 1) {
          const product = a * b;
          if (product < largestValue) break;
          if (product === largestValue) {
            largestFactors.push([a, b]);
            break;
          }
          if (!isPalindrome(product)) continue;
          if (product > largestValue) {
            largestValue = product;
            largestFactors = [[a, b]];
          } else {
            largestFactors.push([a, b]);
          }
        }
      }

      results = {
        smallest: {
          value: smallestValue === Infinity ? null : smallestValue,
          factors: smallestFactors,
        },
        largest: {
          value: largestValue === -Infinity ? null : largestValue,
          factors: largestFactors,
        },
      };
      return results;
    };

    return {
      get smallest() {
        return calculate().smallest;
      },
      get largest() {
        return calculate().largest;
      },
    };
  }
}
