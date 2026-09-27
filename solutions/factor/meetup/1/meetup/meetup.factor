USING: accessors calendar kernel math sequences ;
IN: meetup

CONSTANT: weekdays {
    "Sunday" "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday"
}

CONSTANT: ordinals { "first" "second" "third" "fourth" }

:: meetup ( year month week dayofweek -- timestamp )
    dayofweek weekdays index :> target-day
    week "teenth" = [
        year month 13 <date> :> base
        base day-of-week :> base-day
        13 target-day base-day - 7 + 7 mod +
    ] [
        week "last" = [
            year month 1 <date> days-in-month :> last-day
            year month last-day <date> :> base
            last-day base day-of-week target-day - 7 + 7 mod -
        ] [
            year month 1 <date> :> first-day
            first-day day-of-week :> first-weekday
            1 target-day first-weekday - 7 + 7 mod +
                week ordinals index 7 * +
        ] if
    ] if :> day
    year month day <date> ;
