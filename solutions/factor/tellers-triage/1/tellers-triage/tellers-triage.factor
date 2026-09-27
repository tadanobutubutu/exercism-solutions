USING: arrays heaps kernel sequences ;
IN: tellers-triage

: new-queue ( -- queue )
    <min-heap> ;

:: join-queue ( name priority queue -- queue )
    name priority queue heap-push
    queue ;

: next-name ( queue -- name )
    heap-pop drop ;

:: serve-all ( queue -- names )
    V{ } clone :> names
    [ queue heap-empty? not ] [ queue next-name names push ] while
    names >array ;
