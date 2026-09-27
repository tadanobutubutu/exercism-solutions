USING: grouping kernel sequences ;
IN: proverb

:: recite ( strings -- lines )
    strings empty? [ { } ] [
        strings 2 <clumps> [| pair |
            "For want of a " pair first append
            " the " append pair second append
            " was lost." append
        ] map :> lines
        "And all for the want of a " strings first append "." append
        lines swap suffix
    ] if ;
