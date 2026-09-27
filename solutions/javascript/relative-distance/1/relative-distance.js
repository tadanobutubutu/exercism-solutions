export const degreesOfSeparation = (familyTree, personA, personB) => {
  if (personA === personB) return 0;
  const graph = new Map();
  const connect = (a, b) => {
    if (!graph.has(a)) graph.set(a, new Set());
    if (!graph.has(b)) graph.set(b, new Set());
    graph.get(a).add(b);
    graph.get(b).add(a);
  };
  for (const [parent, children] of Object.entries(familyTree)) {
    if (!graph.has(parent)) graph.set(parent, new Set());
    for (const child of children) connect(parent, child);
    for (let i = 0; i < children.length; i += 1) {
      for (let j = i + 1; j < children.length; j += 1) connect(children[i], children[j]);
    }
  }
  if (!graph.has(personA) || !graph.has(personB)) return -1;

  const queue = [[personA, 0]];
  const visited = new Set([personA]);
  for (let index = 0; index < queue.length; index += 1) {
    const [person, distance] = queue[index];
    for (const relative of graph.get(person)) {
      if (relative === personB) return distance + 1;
      if (!visited.has(relative)) {
        visited.add(relative);
        queue.push([relative, distance + 1]);
      }
    }
  }
  return -1;
};
