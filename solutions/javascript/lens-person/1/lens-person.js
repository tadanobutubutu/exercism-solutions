//
// This is only a SKELETON file for the 'Lens Person' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

/* eslint-disable no-unused-vars */
import { Person } from './person';
import { Name } from './name';
import { Born } from './born';
import { Address } from './address';
import { Lens } from './lens';

// Implement the nameLens with the getter and setter
export const nameLens = new Lens(
  (person) => person.name,
  (person, name) => new Person(name, person.born, person.address),
);

// Implement the bornAtLens with the getter and setter
export const bornAtLens = new Lens(
  (person) => person.born.bornAt,
  (person, address) =>
    new Person(
      person.name,
      new Born(address, person.born.bornOn),
      person.address,
    ),
);

// Implement the streetLens with the getter and setter
export const streetLens = new Lens(
  (person) => person.address.street,
  (person, street) =>
    new Person(
      person.name,
      person.born,
      new Address(
        person.address.houseNumber,
        street,
        person.address.place,
        person.address.country,
      ),
    ),
);
