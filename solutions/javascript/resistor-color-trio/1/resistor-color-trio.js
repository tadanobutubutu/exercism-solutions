const colors = [
  'black', 'brown', 'red', 'orange', 'yellow',
  'green', 'blue', 'violet', 'grey', 'white',
];
const units = ['ohms', 'kiloohms', 'megaohms', 'gigaohms'];

export class ResistorColorTrio {
  constructor(bands) {
    this.bands = bands.slice(0, 3);
  }

  get label() {
    const values = this.bands.map((color) => {
      const value = colors.indexOf(color);
      if (value === -1) throw new Error(`invalid color: ${color}`);
      return value;
    });

    let resistance = (values[0] * 10 + values[1]) * 10 ** values[2];
    let unitIndex = 0;
    while (resistance >= 1000 && unitIndex < units.length - 1) {
      resistance /= 1000;
      unitIndex += 1;
    }
    return `Resistor value: ${resistance} ${units[unitIndex]}`;
  }
}
