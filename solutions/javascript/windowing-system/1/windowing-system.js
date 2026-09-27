// @ts-check

export class Size {
  constructor(width = 80, height = 60) {
    this.width = width;
    this.height = height;
  }

  resize(width, height) {
    this.width = width;
    this.height = height;
  }
}

export class Position {
  constructor(x = 0, y = 0) {
    this.x = x;
    this.y = y;
  }

  move(x, y) {
    this.x = x;
    this.y = y;
  }
}

export class ProgramWindow {
  constructor() {
    this.screenSize = new Size(800, 600);
    this.size = new Size();
    this.position = new Position();
  }

  resize(newSize) {
    this.size.resize(
      Math.min(Math.max(newSize.width, 1), this.screenSize.width - this.position.x),
      Math.min(Math.max(newSize.height, 1), this.screenSize.height - this.position.y),
    );
  }

  move(newPosition) {
    this.position.move(
      Math.min(Math.max(newPosition.x, 0), this.screenSize.width - this.size.width),
      Math.min(Math.max(newPosition.y, 0), this.screenSize.height - this.size.height),
    );
  }
}

export function changeWindow(programWindow) {
  programWindow.resize(new Size(400, 300));
  programWindow.move(new Position(100, 150));
  return programWindow;
}
