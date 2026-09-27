USING: arrays kernel math math.bitwise sequences vectors ;
IN: variable-length-quantity

:: encode-one ( integer -- bytes )
    integer 0 = [ { 0 } ] [
        integer :> remaining!
        V{ } clone :> groups!
        [ remaining 0 > ] [
            remaining 127 bitand groups push
            remaining 128 /i remaining!
        ] while
        groups reverse :> ordered
        ordered but-last [ 128 + ] map
        ordered last 1array append >array
    ] if ;

:: encode ( integers -- bytes )
    integers [ encode-one ] map concat >array ;

:: decode ( bytes -- integers )
    V{ } clone :> values!
    0 :> current!
    f :> pending?!
    bytes [| byte |
        current 128 * byte 127 bitand + current!
        byte 128 bitand 0 = [
            current values push
            0 current!
            f pending?!
        ] [
            t pending?!
        ] if
    ] each
    pending? [ "incomplete sequence" throw ] [ values >array ] if ;
