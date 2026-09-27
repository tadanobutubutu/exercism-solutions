USING: accessors kernel sequences sorting ;
IN: high-scores

TUPLE: high-scores scores ;

: <high-scores> ( scores -- hs )
    high-scores boa ;

: scores ( hs -- scores )
    scores>> ;

: latest ( hs -- score )
    scores>> last ;

: personal-best ( hs -- score )
    scores>> sort last ;

: personal-top-three ( hs -- top-three )
    scores>> sort reverse dup length 3 min head ;
