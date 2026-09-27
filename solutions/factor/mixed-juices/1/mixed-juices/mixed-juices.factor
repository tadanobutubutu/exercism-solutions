USING: assocs kernel locals math sequences ;
IN: mixed-juices

: time-to-mix-juice ( juice -- minutes )
    H{
        { "Pure Strawberry Joy" 0.5 }
        { "Energizer" 1.5 }
        { "Green Garden" 1.5 }
        { "Tropical Island" 3 }
        { "All or Nothing" 5 }
        { "Limetime" 2.5 }
        { "Manic Organic" 2.5 }
        { "Papaya & Peach" 2.5 }
    } at 2.5 or ;

: wedges-from-lime ( size -- wedges )
    H{ { "small" 6 } { "medium" 8 } { "large" 10 } } at ;

:: limes-to-cut ( needed limes -- count )
    limes :> remaining!
    0 :> wedges!
    0 :> count!
    [ wedges needed < remaining empty? not and ] [
        remaining unclip [ remaining! ] dip
        wedges-from-lime wedges + wedges!
        count 1 + count!
    ] while
    count ;

: order-times ( orders -- times )
    [ time-to-mix-juice ] map ;

:: remaining-orders ( time-left orders -- remaining )
    time-left :> time-left!
    orders :> remaining!
    [ time-left 0 > remaining empty? not and ] [
        remaining unclip [ remaining! ] dip
        time-to-mix-juice time-left swap - time-left!
    ] while
    remaining ;
