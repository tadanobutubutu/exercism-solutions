from calendar import monthrange
from datetime import date


# subclassing the built-in ValueError to create MeetupDayException
class MeetupDayException(ValueError):
    """Exception raised when the Meetup weekday and count do not result in a valid date.

    message: explanation of the error.

    """
    def __init__(self, message):
        super().__init__(message)


def meetup(year, month, week, day_of_week):
    target_weekday = {
        "Monday": 0,
        "Tuesday": 1,
        "Wednesday": 2,
        "Thursday": 3,
        "Friday": 4,
        "Saturday": 5,
        "Sunday": 6,
    }[day_of_week]
    days_in_month = monthrange(year, month)[1]
    matching_days = [
        date(year, month, day)
        for day in range(1, days_in_month + 1)
        if date(year, month, day).weekday() == target_weekday
    ]

    if week == "teenth":
        choices = [day for day in matching_days if 13 <= day.day <= 19]
    elif week == "last":
        choices = matching_days[-1:]
    else:
        position = {"first": 0, "second": 1, "third": 2, "fourth": 3, "fifth": 4}[week]
        choices = matching_days[position:position + 1]

    if not choices:
        raise MeetupDayException("That day does not exist.")
    return choices[0]
