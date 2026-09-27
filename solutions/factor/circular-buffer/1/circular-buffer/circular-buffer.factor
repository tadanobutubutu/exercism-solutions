USING: accessors arrays kernel math sequences vectors ;
IN: circular-buffer

ERROR: buffer-empty ;
ERROR: buffer-full ;

TUPLE: circular-buffer capacity head size data ;

:: <circular-buffer> ( capacity -- buffer )
    circular-buffer new
        capacity >>capacity
        0 >>head
        0 >>size
        capacity [ f ] replicate >array >>data ;

:: write ( item buffer -- )
    buffer size>> buffer capacity>> >= [ buffer-full ] when
    buffer head>> buffer size>> + buffer capacity>> mod :> index
    item index buffer data>> set-nth
    buffer buffer size>> 1 + >>size drop ;

:: read ( buffer -- item )
    buffer size>> zero? [ buffer-empty ] when
    buffer head>> buffer data>> nth :> item
    buffer buffer head>> 1 + buffer capacity>> mod >>head drop
    buffer buffer size>> 1 - >>size drop
    item ;

:: overwrite ( item buffer -- )
    buffer size>> buffer capacity>> = [
        item buffer head>> buffer data>> set-nth
        buffer buffer head>> 1 + buffer capacity>> mod >>head drop
    ] [
        item buffer write
    ] if ;

:: clear-buffer ( buffer -- )
    buffer 0 >>head
    0 >>size drop ;
