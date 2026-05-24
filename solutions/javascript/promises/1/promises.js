export const promisify = (fn) => {
  return (value) =>
    new Promise((resolve, reject) => {
      fn(value, (err, result) => {
        if (err) reject(err);
        else resolve(result);
      });
    });
};

export const all = (promises) => {
  if (promises === undefined) return Promise.resolve(undefined);
  return Promise.all(promises);
};

export const allSettled = (promises) => {
  if (promises === undefined) return Promise.resolve(undefined);
  return Promise.all(promises.map((p) => p.then((v) => v, (e) => e)));
};

export const race = (promises) => {
  if (promises === undefined) return Promise.resolve(undefined);
  if (promises.length === 0) return Promise.resolve([]);
  return Promise.race(promises);
};

export const any = (promises) => {
  if (promises === undefined) return Promise.resolve(undefined);
  return new Promise((resolve, reject) => {
    const errors = [];
    let pending = promises.length;
    if (pending === 0) {
      reject(errors);
      return;
    }
    promises.forEach((p, i) => {
      Promise.resolve(p).then(
        (v) => resolve(v),
        (e) => {
          errors[i] = e;
          if (--pending === 0) reject(errors);
        },
      );
    });
  });
};
