USING: kernel locals math math.order math.parser sequences ;
IN: raindrops

:: convert ( n -- str )
    ""
    n 3 mod 0 = [ "Pling" append ] when
    n 5 mod 0 = [ "Plang" append ] when
    n 7 mod 0 = [ "Plong" append ] when
    dup empty? [ drop n number>string ] when ;
