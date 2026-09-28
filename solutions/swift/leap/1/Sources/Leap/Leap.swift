class Year {
  private let calendarYear: Int

  var isLeapYear: Bool {
    calendarYear.isMultiple(of: 400)
      || (calendarYear.isMultiple(of: 4) && !calendarYear.isMultiple(of: 100))
  }

  init(calendarYear: Int) {
    self.calendarYear = calendarYear
  }
}
