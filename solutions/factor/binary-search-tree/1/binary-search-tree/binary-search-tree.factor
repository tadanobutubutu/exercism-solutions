USING: accessors arrays kernel locals math.order sequences ;
IN: binary-search-tree

TUPLE: bst ;
TUPLE: leaf < bst ;
TUPLE: branch < bst data left right ;

GENERIC: insert-data ( item tree -- tree )

M:: leaf insert-data ( item tree -- node )
    item leaf boa leaf boa branch boa ;

M:: branch insert-data ( item tree -- tree )
    item tree data>> before=? [
        tree item tree left>> insert-data >>left drop
    ] [
        tree item tree right>> insert-data >>right drop
    ] if
    tree ;

: build-tree ( data-seq -- tree )
    dup first leaf boa leaf boa branch boa
    swap rest swap [ swap insert-data ] reduce ;

: <bst> ( data-seq -- tree )
    dup empty? [ drop leaf boa ] [ build-tree ] if ;

GENERIC: sorted-data ( tree -- seq )

M: leaf sorted-data
    drop { } ;

M:: branch sorted-data ( tree -- seq )
    tree left>> sorted-data
    tree data>> 1array append
    tree right>> sorted-data append ;
