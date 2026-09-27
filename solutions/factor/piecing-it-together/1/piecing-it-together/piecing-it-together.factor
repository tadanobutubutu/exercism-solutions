USING: arrays assocs kernel math math.functions math.order ranges sequences vectors ;
IN: piecing-it-together

:: inside-count ( rows columns -- inside )
    rows 2 - 0 max columns 2 - 0 max * ;

:: border-count ( rows columns -- border )
    rows columns * rows columns inside-count - ;

:: puzzle-format ( rows columns -- format )
    columns rows = [ "square" ] [
        columns rows < [ "portrait" ] [ "landscape" ] if
    ] if ;

:: add-pair ( rows columns pairs -- )
    rows columns 2array :> pair
    pair pairs member? [ ] [ pair pairs push ] if ;

:: candidates-from-pieces ( pieces -- pairs )
    V{ } clone :> pairs
    pieces 1 >= [
        1 pieces sqrt floor [a..b] [| rows |
            pieces rows mod zero? [
                pieces rows /i :> columns
                rows columns pairs add-pair
                columns rows pairs add-pair
            ] when
        ] each
    ] when
    pairs ;

:: candidates-from-border ( border -- pairs )
    V{ } clone :> pairs
    border 1 >= [ 1 border pairs add-pair ] when
    border 4 >= [
        border 4 + 2 mod zero? [
            border 4 + 2 /i :> dimension-sum
            2 dimension-sum 2 - [a..b] [| rows |
                rows dimension-sum rows - pairs add-pair
            ] each
        ] when
    ] when
    pairs ;

:: candidates-from-inside ( inside -- pairs )
    V{ } clone :> pairs
    inside 1 >= [
        1 inside sqrt floor [a..b] [| inner-rows |
            inside inner-rows mod zero? [
                inside inner-rows /i :> inner-columns
                inner-rows 2 + inner-columns 2 + pairs add-pair
                inner-columns 2 + inner-rows 2 + pairs add-pair
            ] when
        ] each
    ] when
    pairs ;

:: candidates-from-row-aspect ( rows aspect -- pairs )
    V{ } clone :> pairs
    rows aspect * :> estimate
    estimate round >integer :> columns
    estimate columns - abs 0.000001 < [ rows columns pairs add-pair ] when
    pairs ;

:: candidates-from-column-aspect ( columns aspect -- pairs )
    V{ } clone :> pairs
    columns 1.0 * aspect /f :> estimate
    estimate round >integer :> rows
    estimate rows - abs 0.000001 < [ rows columns pairs add-pair ] when
    pairs ;

:: candidate-pairs ( partial -- pairs/f )
    "rows" partial at :> known-rows
    "columns" partial at :> known-columns
    "pieces" partial at :> pieces
    "border" partial at :> border
    "inside" partial at :> inside
    "aspectRatio" partial at :> aspect
    "format" partial at :> format

    known-rows f = not known-columns f = not and [
        V{ } clone :> pairs
        known-rows known-columns pairs add-pair
        pairs
    ] [
        pieces f = not [ pieces candidates-from-pieces ] [
            border f = not [ border candidates-from-border ] [
                inside f = not [ inside 0 > ] [ f ] if [ inside candidates-from-inside ] [
                    known-rows f = not aspect f = not and [
                        known-rows aspect candidates-from-row-aspect
                    ] [
                        known-columns f = not aspect f = not and [
                            known-columns aspect candidates-from-column-aspect
                        ] [
                            known-rows f = not format "square" = and [
                                V{ } clone :> pairs
                                known-rows known-rows pairs add-pair
                                pairs
                            ] [
                                known-columns f = not format "square" = and [
                                    V{ } clone :> pairs
                                    known-columns known-columns pairs add-pair
                                    pairs
                                ] [ f ] if
                            ] if
                        ] if
                    ] if
                ] if
            ] if
        ] if
    ] if ;

:: matches-field? ( actual partial key -- ? )
    key partial at :> expected
    expected f = [ t ] [ actual expected = ] if ;

:: matches-aspect? ( rows columns partial -- ? )
    "aspectRatio" partial at :> expected
    expected f = [ t ] [ columns rows /f expected - abs 0.000001 < ] if ;

:: consistent-pair? ( pair partial -- ? )
    pair first :> rows
    pair second :> columns
    rows 1 >= columns 1 >= and
    rows partial "rows" matches-field? and
    columns partial "columns" matches-field? and
    rows columns * partial "pieces" matches-field? and
    rows columns inside-count partial "inside" matches-field? and
    rows columns border-count partial "border" matches-field? and
    rows columns puzzle-format partial "format" matches-field? and
    rows columns partial matches-aspect? and ;

:: complete-jigsaw ( rows columns -- full )
    H{ } clone :> full
    rows columns * :> pieces
    rows columns inside-count :> inside
    pieces inside - :> border
    pieces "pieces" full set-at
    border "border" full set-at
    inside "inside" full set-at
    rows "rows" full set-at
    columns "columns" full set-at
    columns rows /f "aspectRatio" full set-at
    rows columns puzzle-format "format" full set-at
    full ;

:: jigsaw-data ( partial -- full )
    partial candidate-pairs :> candidates
    candidates f = [ "Insufficient data" throw ] when
    candidates [| pair | pair partial consistent-pair? ] filter :> valid
    valid empty? [ "Contradictory data" throw ] when
    valid length 1 = [
        valid first first2 complete-jigsaw
    ] [
        "Insufficient data" throw
    ] if ;
