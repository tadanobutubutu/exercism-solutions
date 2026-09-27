USING: kernel math math.order sequences sets unicode ;
IN: pangram

: pangram? ( sentence -- ? )
    >lower [ dup CHAR: a >= swap CHAR: z <= and ] filter
    members length 26 = ;
