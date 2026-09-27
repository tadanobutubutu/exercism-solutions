//
// This is only a SKELETON file for the 'Promises' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const promisify = (callbackFunction) => (...args) =>
  new Promise((resolve, reject) => {
    callbackFunction(...args, (error, value) => {
      if (error) reject(error);
      else resolve(value);
    });
  });

export const all = (...args) => {
  if (args.length === 0) return Promise.resolve(undefined);
  return Promise.all(args[0]);
};

export const allSettled = (...args) => {
  if (args.length === 0) return Promise.resolve(undefined);
  return Promise.all(args[0].map((promise) => Promise.resolve(promise).catch((error) => error)));
};

export const race = (...args) => {
  if (args.length === 0) return Promise.resolve(undefined);
  if (args[0].length === 0) return Promise.resolve([]);
  return Promise.race(args[0]);
};

export const any = (...args) => {
  if (args.length === 0) return Promise.resolve(undefined);
  const promises = args[0];
  if (promises.length === 0) return Promise.reject([]);
  return new Promise((resolve, reject) => {
    const errors = Array(promises.length);
    let rejected = 0;
    promises.forEach((promise, index) => {
      Promise.resolve(promise).then(resolve, (error) => {
        errors[index] = error;
        rejected += 1;
        if (rejected === promises.length) reject(errors);
      });
    });
  });
};
