USING: calendar calendar.format calendar.parser io.streams.string kernel sequences ;
IN: gigasecond

:: gigasecond-after ( date-string -- result )
    date-string length 10 = [
        date-string "T00:00:00Z" append
    ] [
        date-string "Z" append
    ] if
    rfc3339>timestamp 1000000000 seconds time+
    [ { YYYY-MM-DD "T" hh:mm:ss } formatted ] with-string-writer ;
