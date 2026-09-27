USING: arrays kernel math sequences ;
IN: food-chain

CONSTANT: animals { "fly" "spider" "bird" "cat" "dog" "goat" "cow" "horse" }

CONSTANT: special-lyrics {
    ""
    "It wriggled and jiggled and tickled inside her."
    "How absurd to swallow a bird!"
    "Imagine that, to swallow a cat!"
    "What a hog, to swallow a dog!"
    "Just opened her throat and swallowed a goat!"
    "I don't know how she swallowed a cow!"
    "She's dead, of course!"
}

:: swallowed-line ( i -- line )
    i animals nth :> animal
    i 1 - animals nth :> prey
    "She swallowed the " animal append " to catch the " append prey append
    prey "spider" = [
        " that wriggled and jiggled and tickled inside her." append
    ] [ "." append ] if ;

:: verse ( index -- lines )
    "I know an old lady who swallowed a " index 1 - animals nth append "." append :> opening
    index 1 = [
        opening 1array { "I don't know why she swallowed the fly. Perhaps she'll die." } append
    ] [
        index 8 = [
            opening 1array { "She's dead, of course!" } append
        ] [
            index 1 - special-lyrics nth :> lyric
            lyric empty? [ { } ] [ lyric 1array ] if :> special
            index <iota> reverse [ 0 > ] filter [ swallowed-line ] map :> chain
            opening 1array special append chain append
                { "I don't know why she swallowed the fly. Perhaps she'll die." } append
        ] if
    ] if ;

:: food-chain ( start end -- lines )
    start end > [ { } ] [
        start verse :> current
        start 1 + end food-chain :> rest
        rest empty? [ current ] [ current { "" } append rest append ] if
    ] if ;
