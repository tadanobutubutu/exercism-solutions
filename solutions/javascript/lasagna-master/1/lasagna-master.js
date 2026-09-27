/// <reference path="./global.d.ts" />
// @ts-check

/** @param {number | undefined} timer */
export function cookingStatus(timer) {
  if (timer === undefined) return 'You forgot to set the timer.';
  return timer === 0 ? 'Lasagna is done.' : 'Not done, please wait.';
}

/** @param {string[]} layers @param {number} [averageTimePerLayer] */
export function preparationTime(layers, averageTimePerLayer = 2) {
  return layers.length * averageTimePerLayer;
}

/** @param {string[]} layers */
export function quantities(layers) {
  return {
    noodles: layers.filter((layer) => layer === 'noodles').length * 50,
    sauce: layers.filter((layer) => layer === 'sauce').length * 0.2,
  };
}

/** @param {string[]} friendsList @param {string[]} myList */
export function addSecretIngredient(friendsList, myList) {
  myList.push(friendsList.at(-1));
}

/** @param {Record<string, number>} recipe @param {number} [people] */
export function scaleRecipe(recipe, people = 2) {
  const factor = people / 2;
  return Object.fromEntries(
    Object.entries(recipe).map(([ingredient, amount]) => [ingredient, amount * factor]),
  );
}
