export class TwoBucket {
  constructor(bucketOne, bucketTwo, goal, startBucket) {
    if (
      !Number.isInteger(bucketOne) || !Number.isInteger(bucketTwo) ||
      !Number.isInteger(goal) || bucketOne <= 0 || bucketTwo <= 0 ||
      goal < 0 || goal > Math.max(bucketOne, bucketTwo) ||
      !['one', 'two'].includes(startBucket)
    ) {
      throw new Error('Invalid bucket sizes, goal, or starting bucket');
    }

    const gcd = (a, b) => (b === 0 ? a : gcd(b, a % b));
    if (goal !== 0 && goal % gcd(bucketOne, bucketTwo) !== 0) {
      throw new Error('The goal cannot be measured with these buckets');
    }

    this.capacities = [bucketOne, bucketTwo];
    this.goal = goal;
    this.startBucket = startBucket === 'one' ? 0 : 1;
  }

  solve() {
    const [capacityOne, capacityTwo] = this.capacities;
    const initial = this.startBucket === 0
      ? [capacityOne, 0]
      : [0, capacityTwo];
    const otherBucket = 1 - this.startBucket;
    const queue = [{ state: initial, moves: 1 }];
    const visited = new Set();

    for (let head = 0; head < queue.length; head += 1) {
      const { state, moves } = queue[head];
      const key = state.join(',');
      if (visited.has(key)) continue;
      visited.add(key);

      if (state[0] === this.goal || state[1] === this.goal) {
        const goalIndex = state[0] === this.goal ? 0 : 1;
        return {
          moves,
          goalBucket: goalIndex === 0 ? 'one' : 'two',
          otherBucket: state[1 - goalIndex],
        };
      }

      const nextStates = [];
      nextStates.push([capacityOne, state[1]]);
      nextStates.push([state[0], capacityTwo]);
      nextStates.push([0, state[1]]);
      nextStates.push([state[0], 0]);

      const pour = (from, to) => {
        const amount = Math.min(state[from], this.capacities[to] - state[to]);
        const next = [...state];
        next[from] -= amount;
        next[to] += amount;
        return next;
      };
      nextStates.push(pour(0, 1), pour(1, 0));

      for (const next of nextStates) {
        if (next[0] === state[0] && next[1] === state[1]) continue;
        if (this.startBucket === 0 && next[0] === 0 && next[1] === capacityTwo) continue;
        if (this.startBucket === 1 && next[1] === 0 && next[0] === capacityOne) continue;
        if (!visited.has(next.join(','))) queue.push({ state: next, moves: moves + 1 });
      }
    }

    throw new Error('The goal cannot be reached while following the bucket rules');
  }
}
