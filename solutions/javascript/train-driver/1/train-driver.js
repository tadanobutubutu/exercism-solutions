export function getListOfWagons(...ids) {
  return ids;
}

export function fixListOfWagons(ids) {
  const wagons = Array.from(ids);
  return [...wagons.slice(2), ...wagons.slice(0, 2)];
}

export function correctListOfWagons(ids, missingWagons) {
  const [first, ...remaining] = ids;
  return [first, ...missingWagons, ...remaining];
}

export function extendRouteInformation(information, additional) {
  return { ...information, ...additional };
}

export function separateTimeOfArrival(information) {
  const { timeOfArrival, ...route } = information;
  return [timeOfArrival, route];
}
