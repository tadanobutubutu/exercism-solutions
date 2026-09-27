USING: kernel sets sequences unicode ;
IN: isogram

: isogram? ( phrase -- ? )
    >lower
    [ dup CHAR: space = swap CHAR: - = or not ] filter
    dup length swap members length = ;
