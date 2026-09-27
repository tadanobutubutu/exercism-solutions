//
// This is only a SKELETON file for the 'Meetup' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const meetup = (year, month, descriptor, weekday) => {
  const weekdays = {
    Sunday: 0,
    Monday: 1,
    Tuesday: 2,
    Wednesday: 3,
    Thursday: 4,
    Friday: 5,
    Saturday: 6,
  };
  const targetWeekday = weekdays[weekday];
  const daysInMonth = new Date(year, month, 0).getDate();
  let matchingDays = [];

  if (descriptor === 'teenth') {
    for (let day = 13; day <= 19; day += 1) {
      if (new Date(year, month - 1, day).getDay() === targetWeekday) {
        return new Date(year, month - 1, day);
      }
    }
  } else {
    matchingDays = Array.from({ length: daysInMonth }, (_, index) => index + 1)
      .filter(day => new Date(year, month - 1, day).getDay() === targetWeekday);
    const index = { first: 0, second: 1, third: 2, fourth: 3 }[descriptor];
    const day = descriptor === 'last'
      ? matchingDays.at(-1)
      : matchingDays[index];
    return new Date(year, month - 1, day);
  }
};
