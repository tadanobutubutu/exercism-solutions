USING: accessors assocs kernel math sequences ;
IN: satellite

TUPLE: tree value left right ;

ERROR: invalid-traversals ;

:: all-distinct? ( values -- ? )
    H{ } clone :> seen
    values [| value |
        value seen key? [ f ] [
            t value seen set-at
            t
        ] if
    ] all? ;

:: consistent-traversals? ( preorder inorder -- ? )
    preorder length inorder length =
    preorder all-distinct? and
    inorder all-distinct? and
    preorder [| value | value inorder member? ] all? and ;

:: build-tree ( preorder inorder -- tree/f )
    preorder empty? [ f ] [
        preorder first :> root
        0 :> index!
        f :> root-index!
        inorder [| value |
            value root = [ index root-index! ] when
            index 1 + index!
        ] each
        root-index :> left-size
        1 left-size 1 + preorder subseq :> left-preorder
        left-size 1 + preorder length preorder subseq :> right-preorder
        0 left-size inorder subseq :> left-inorder
        left-size 1 + inorder length inorder subseq :> right-inorder
        left-preorder left-inorder build-tree :> left-tree
        right-preorder right-inorder build-tree :> right-tree
        tree new
            root >>value
            left-tree >>left
            right-tree >>right
    ] if ;

:: tree-from-traversals ( preorder inorder -- tree/f )
    preorder inorder consistent-traversals? [
        preorder inorder build-tree
    ] [ invalid-traversals ] if ;
