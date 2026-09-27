USING: calendar kernel sequences ;
IN: ferry-schedule

: make-date ( year month day -- timestamp )
    <date> ;

: weekday-name ( timestamp -- name )
    day-of-week
    { "Sunday" "Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday" }
    nth ;

: leap? ( year -- ? )
    leap-year? ;

: month-length ( year month -- n )
    1 <date> days-in-month ;

: add-days ( timestamp n -- timestamp )
    days time+ ;
