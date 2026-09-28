class Squares {
  private let count: Int

  init(_ count: Int) {
    self.count = count
  }

  var squareOfSum: Int {
    let sum = count * (count + 1) / 2
    return sum * sum
  }

  var sumOfSquares: Int {
    count * (count + 1) * (2 * count + 1) / 6
  }

  var differenceOfSquares: Int {
    squareOfSum - sumOfSquares
  }
}
