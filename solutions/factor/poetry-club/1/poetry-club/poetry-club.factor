USING: disjoint-sets kernel locals ;
IN: poetry-club

:: new-club ( poets -- club )
    <disjoint-set> :> club
    poets club add-atoms
    club ;

:: collaborate ( poet1 poet2 club -- club )
    poet1 poet2 club equate
    club ;

:: circle-of ( poet club -- representative )
    poet club representative ;

:: same-circle? ( poet1 poet2 club -- ? )
    poet1 club representative poet2 club representative = ;
