USING: arrays kernel math sequences ;
IN: rectangles

:: horizontal-char? ( character -- ? )
    character CHAR: + = character CHAR: - = or ;

:: vertical-char? ( character -- ? )
    character CHAR: + = character CHAR: | = or ;

:: horizontal-side? ( row left right -- ? )
    right left - 1 + <iota> [| offset |
        left offset + row nth horizontal-char?
    ] all? ;

:: vertical-side? ( grid column top bottom -- ? )
    bottom top - 1 + <iota> [| offset |
        top offset + grid nth column swap nth vertical-char?
    ] all? ;

:: rectangle? ( grid top bottom left right -- ? )
    top grid nth :> top-row
    bottom grid nth :> bottom-row
    left top-row nth CHAR: + =
    right top-row nth CHAR: + = and
    left bottom-row nth CHAR: + = and
    right bottom-row nth CHAR: + = and
    top-row left right horizontal-side? and
    bottom-row left right horizontal-side? and
    grid left top bottom vertical-side? and
    grid right top bottom vertical-side? and ;

:: count-rectangles ( grid -- n )
    grid length :> height
    height 2 < [ 0 ] [
        grid first length :> width
        0 :> count!
        height <iota> [| top |
            height <iota> [| bottom |
                bottom top > [
                    width <iota> [| left |
                        width <iota> [| right |
                            right left > [
                                grid top bottom left right rectangle? [
                                    count 1 + count!
                                ] when
                            ] when
                        ] each
                    ] each
                ] when
            ] each
        ] each
        count
    ] if ;
