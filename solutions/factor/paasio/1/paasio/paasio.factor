USING: accessors destructors io kernel locals math sequences ;
IN: paasio

! Define `metered-input` and `metered-output` tuples that wrap an
! underlying input or output stream, then implement the stream
! protocol generics so reads/writes update the wrapper's `bytes`
! and `ops` slots.
!
! For the wrappers to plug into Factor's I/O, you'll need to
! provide methods on `stream-read1`, `stream-read-unsafe`,
! `stream-element-type`, and `dispose*` for `metered-input`;
! `stream-write1`, `stream-write`, `stream-flush`, and `dispose*`
! for `metered-output`. Mark them as instances of the
! `input-stream` / `output-stream` mixins so they're recognized
! by Factor's I/O combinators.

TUPLE: metered-input < disposable stream bytes ops ;
TUPLE: metered-output < disposable stream bytes ops ;

INSTANCE: metered-input input-stream
INSTANCE: metered-output output-stream

: <metered-input> ( stream -- m )
    metered-input new-disposable
        0 >>bytes
        0 >>ops
    swap >>stream ;

: <metered-output> ( stream -- m )
    metered-output new-disposable
        0 >>bytes
        0 >>ops
    swap >>stream ;

M:: metered-input stream-read1 ( m -- elt/f )
    m stream>> stream-read1 :> elt
    m dup bytes>> elt [ 1 ] [ 0 ] if + >>bytes drop
    m dup ops>> 1 + >>ops drop
    elt ;

M:: metered-input stream-read-unsafe ( n buf m -- count )
    n buf m stream>> stream-read-unsafe :> count
    m dup bytes>> count + >>bytes drop
    m dup ops>> 1 + >>ops drop
    count ;

M: metered-input stream-element-type
    stream>> stream-element-type ;

M: metered-input dispose*
    stream>> dispose ;

M:: metered-output stream-write1 ( elt m -- )
    elt m stream>> stream-write1
    m dup bytes>> 1 + >>bytes drop
    m dup ops>> 1 + >>ops drop ;

M:: metered-output stream-write ( seq m -- )
    seq length :> count
    seq m stream>> stream-write
    m dup bytes>> count + >>bytes drop
    m dup ops>> 1 + >>ops drop ;

M: metered-output stream-flush
    stream>> stream-flush ;

M: metered-output dispose*
    stream>> dispose ;
