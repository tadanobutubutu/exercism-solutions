USING: arrays kernel math sequences vectors ;
IN: saddle-points

:: saddle-points ( matrix -- points )
    V{ } clone :> points
    matrix length :> height
    height 0 = [
        points >array
    ] [
        matrix first length :> width
        height <iota> [| row-index |
            row-index matrix nth :> row
            width <iota> [| column-index |
                column-index row nth :> value
                row [ value swap >= ] all?
                matrix [| other-row | column-index other-row nth ] map
                    [ value swap <= ] all? and [
                    row-index 1 + column-index 1 + 2array points push
                ] when
            ] each
        ] each
        points >array
    ] if ;
