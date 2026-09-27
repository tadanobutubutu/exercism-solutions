USING: accessors arrays kernel locals math math.parser sequences splitting ;
IN: split-second-stopwatch

TUPLE: stopwatch status current previous ;

:: pad-two ( number -- string )
    number number>string dup length 2 < [ "0" swap append ] when ;

:: hms>seconds ( hours minutes seconds -- total )
    hours 3600 * minutes 60 * + seconds + ;

:: time>seconds ( time -- total )
    time ":" split [ string>number ] map first3 hms>seconds ;

:: seconds>time ( total -- time )
    total 3600 /i :> hours
    total 3600 mod 60 /i :> minutes
    total 60 mod :> seconds
    hours pad-two ":" append minutes pad-two append ":" append seconds pad-two append ;

! Define a `stopwatch` tuple to hold the current state, the
! current lap's elapsed seconds, and the previously recorded
! laps. `<stopwatch>` should return a new stopwatch in the
! "ready" state.

! `state` returns "ready", "running", or "stopped".
! `current-lap` and `total` return "HH:MM:SS" strings.
! `previous-laps` returns an array of "HH:MM:SS" strings.
! `advance-time` takes an "HH:MM:SS" string and adds it to the
! current lap (only while running).
! `start`, `stop`, `reset`, and `lap` change the state, throwing
! when called from a state that does not allow them.

: <stopwatch> ( -- stopwatch )
    "ready" 0 V{ } clone stopwatch boa ;

: state ( stopwatch -- str )
    status>> ;

: current-lap ( stopwatch -- str )
    current>> seconds>time ;

:: total ( stopwatch -- str )
    stopwatch previous>> sum stopwatch current>> + seconds>time ;

:: previous-laps ( stopwatch -- seq )
    stopwatch previous>> [ seconds>time ] map >array ;

:: advance-time ( str stopwatch -- )
    stopwatch status>> "running" = [
        stopwatch current>> str time>seconds + :> updated
        stopwatch updated >>current drop
    ] when ;

:: start ( stopwatch -- )
    stopwatch status>> "running" = [ "cannot start while running" throw ] when
    stopwatch "running" >>status drop ;

:: stop ( stopwatch -- )
    stopwatch status>> "running" = [ ] [ "cannot stop unless running" throw ] if
    stopwatch "stopped" >>status drop ;

:: reset ( stopwatch -- )
    stopwatch status>> "stopped" = [ ] [ "cannot reset unless stopped" throw ] if
    stopwatch "ready" >>status drop
    stopwatch 0 >>current drop
    stopwatch V{ } clone >>previous drop ;

:: lap ( stopwatch -- )
    stopwatch status>> "running" = [ ] [ "cannot lap unless running" throw ] if
    stopwatch current>> stopwatch previous>> push
    stopwatch 0 >>current drop ;
