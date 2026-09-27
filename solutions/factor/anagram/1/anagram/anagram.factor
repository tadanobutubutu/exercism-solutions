USING: kernel sequences sorting unicode vectors ;
IN: anagram

:: find-anagrams ( subject candidates -- anagrams )
    subject >lower :> folded-subject
    folded-subject sort :> sorted-subject
    candidates [| candidate |
        candidate >lower :> folded-candidate
        folded-candidate folded-subject = not
        folded-candidate sort sorted-subject = and
    ] filter >vector ;
