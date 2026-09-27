USING: kernel locals math math.order math.statistics sequences ;
IN: librarians-ledger

:: protected-balance ( opening requests -- balance )
    requests opening [ + 0 max ] reduce ;

:: running-balance ( transactions -- balances )
    transactions cum-sum ;

:: least-balance-so-far ( transactions -- worsts )
    transactions cum-sum cum-min ;

:: halve-until ( principal target -- balances )
    target principal [ 2dup swap > ] [ 2 /i dup ] produce 2nip ;
