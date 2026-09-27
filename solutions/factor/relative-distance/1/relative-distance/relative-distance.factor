USING: accessors arrays assocs deques dlists hash-sets hashtables
kernel math sequences sets ;
IN: relative-distance

:: ensure-person ( person graph -- neighbours )
    person graph at* [ ] [
        drop HS{ } clone :> neighbours
        neighbours person graph set-at
        neighbours
    ] if ;

:: degree-of-separation ( family-tree person-a person-b -- n/f )
    person-a person-b = [ 0 ] [
        H{ } clone :> graph
        family-tree [| parent children |
            parent graph ensure-person :> parent-neighbours
            children [| child |
                child graph ensure-person :> child-neighbours
                child parent-neighbours adjoin
                parent child-neighbours adjoin
                children [| sibling |
                    sibling child = not [ sibling child-neighbours adjoin ] when
                ] each
            ] each
        ] assoc-each
        HS{ } clone :> visited
        <dlist> :> frontier
        person-a visited adjoin
        person-a 0 2array frontier push-back
        f :> answer!
        [ frontier deque-empty? answer or ] [
            frontier pop-front :> entry
            entry first :> current
            entry second :> distance
            current person-b = [
                distance answer!
            ] [
                current graph at :> neighbours
                neighbours [
                    neighbours members [| neighbour |
                        neighbour visited in? not [
                            neighbour visited adjoin
                            neighbour distance 1 + 2array frontier push-back
                        ] when
                    ] each
                ] when
            ] if
        ] until
        answer
    ] if ;
