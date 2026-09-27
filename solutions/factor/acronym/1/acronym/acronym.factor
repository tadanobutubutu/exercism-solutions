USING: kernel sequences splitting strings unicode ;
IN: acronym

: abbreviate ( phrase -- acronym )
    [ dup CHAR: space = swap CHAR: - = or ] split-when
    [ >lower [ letter? ] filter ] map
    [ empty? not ] filter
    [ first ch>upper ] map >string ;
