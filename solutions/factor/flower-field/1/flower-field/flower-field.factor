USING: kernel math sequences unicode ;
IN: flower-field

:: flower-at? ( garden row col -- ? )
    row 0 >= row garden length < and [
        row garden nth :> line
        col 0 >= col line length < and [
            col line nth CHAR: * =
        ] [ f ] if
    ] [ f ] if ;

:: neighbor-count ( garden row col -- count )
    0 :> count!
    { -1 0 1 } [| row-offset |
        { -1 0 1 } [| col-offset |
            row-offset 0 = col-offset 0 = and not [
                garden row row-offset + col col-offset + flower-at?
                [ count 1 + count! ] when
            ] when
        ] each
    ] each
    count ;

:: annotate-row ( line garden row -- annotated-line )
    line [| character col |
        character CHAR: * = [ CHAR: * ] [
            garden row col neighbor-count :> flowers
            flowers 0 = [ CHAR: space ] [ 48 flowers + ] if
        ] if
    ] map-index ;

:: annotate ( garden -- annotated )
    garden [| line row | line garden row annotate-row ] map-index ;
