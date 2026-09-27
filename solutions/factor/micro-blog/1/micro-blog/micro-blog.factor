USING: kernel sequences ;
IN: micro-blog

: truncate ( str -- str' )
    5 index-or-length head ;
