USING: arrays kernel math math.combinatorics sequences ;
IN: zebra-puzzle

SYMBOLS: Englishman Spaniard Ukrainian Norwegian Japanese ;
SYMBOLS: Red Green Ivory Yellow Blue ;
SYMBOLS: Coffee Tea Milk OrangeJuice Water ;
SYMBOLS: Dog Snails Fox Horse Zebra ;
SYMBOLS: Dancing Painter Football Chess Reading ;

:: position-of ( values target -- position )
    f :> found!
    0 :> index!
    values [| value |
        value target = [ index found! ] when
        index 1 + index!
    ] each
    found ;

:: adjacent? ( left right -- ? )
    left right - abs 1 = ;

:: nationality-layout-valid? ( colors nationalities -- ? )
    nationalities Englishman position-of colors Red position-of =
    nationalities Norwegian position-of 0 = and
    nationalities Norwegian position-of colors Blue position-of adjacent? and ;

:: drink-layout-valid? ( colors nationalities drinks -- ? )
    drinks Coffee position-of colors Green position-of =
    drinks Tea position-of nationalities Ukrainian position-of = and
    drinks Milk position-of 2 = and ;

:: hobby-layout-valid? ( nationalities colors drinks hobbies -- ? )
    hobbies Painter position-of colors Yellow position-of =
    hobbies Football position-of drinks OrangeJuice position-of = and
    hobbies Chess position-of nationalities Japanese position-of = and ;

:: pet-layout-valid? ( nationalities hobbies pets -- ? )
    pets Dog position-of nationalities Spaniard position-of =
    pets Snails position-of hobbies Dancing position-of = and
    pets Fox position-of hobbies Reading position-of adjacent? and
    pets Horse position-of hobbies Painter position-of adjacent? and ;

:: solve-puzzle ( -- solution )
    { Red Green Ivory Yellow Blue } all-permutations :> color-permutations
    { Englishman Spaniard Ukrainian Norwegian Japanese } all-permutations :> nationality-permutations
    { Coffee Tea Milk OrangeJuice Water } all-permutations :> drink-permutations
    { Dancing Painter Football Chess Reading } all-permutations :> hobby-permutations
    { Dog Snails Fox Horse Zebra } all-permutations :> pet-permutations
    f :> solution!

    color-permutations [| colors |
        colors Green position-of colors Ivory position-of 1 + =
        solution f = and [
            nationality-permutations [| nationalities |
                colors nationalities nationality-layout-valid?
                solution f = and [
                    drink-permutations [| drinks |
                        colors nationalities drinks drink-layout-valid?
                        solution f = and [
                            hobby-permutations [| hobbies |
                                nationalities colors drinks hobbies hobby-layout-valid?
                                solution f = and [
                                    pet-permutations [| pets |
                                        nationalities hobbies pets pet-layout-valid?
                                        solution f = and [
                                            drinks Water position-of nationalities nth :> water-owner
                                            pets Zebra position-of nationalities nth :> zebra-owner
                                            water-owner zebra-owner 2array solution!
                                        ] when
                                    ] each
                                ] when
                            ] each
                        ] when
                    ] each
                ] when
            ] each
        ] when
    ] each
    solution ;

: drinks-water ( -- nationality )
    solve-puzzle first ;

: owns-zebra ( -- nationality )
    solve-puzzle second ;
