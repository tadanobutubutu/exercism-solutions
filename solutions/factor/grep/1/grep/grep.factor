USING: arrays ascii io.encodings.utf8 io.files kernel math math.parser
       sequences strings vectors ;
IN: grep

! `grep` receives the search string, an array of flag strings
! (any of "-n", "-l", "-i", "-v", "-x"), and an array of file
! names. Read each file in turn, find the matching lines, and
! return them as an array of strings.
!
! Reading a file's lines: `<file-name> utf8 file-lines` (from the
! `io.files` and `io.encodings.utf8` vocabularies).

:: line-matches? ( line pattern flags -- ? )
    "-i" flags member? [
        "-x" flags member? [
            line >lower pattern >lower =
        ] [
            pattern >lower line >lower subseq?
        ] if
    ] [
        "-x" flags member? [
            line pattern =
        ] [
            pattern line subseq?
        ] if
    ] if
    "-v" flags member? [ not ] when ;

:: format-line ( filename line-number line flags multi-file? -- formatted )
    "" :> prefix!
    multi-file? [ prefix filename append ":" append prefix! ] when
    "-n" flags member? [
        prefix line-number number>string ":" append append prefix!
    ] when
    prefix line append ;

:: grep ( pattern flags files -- lines )
    V{ } clone :> output
    files length 1 > :> multi-file?
    "-l" flags member? :> list-files?
    files [
        :> filename
        filename utf8 file-lines :> contents
        list-files? [
            contents [| line | line pattern flags line-matches? ] any?
            [ filename output push ] when
        ] [
            contents [| line line-index |
                line pattern flags line-matches? [
                    filename line-index 1 + line flags multi-file? format-line
                    output push
                ] when
            ] each-index
        ] if
    ] each
    output >array ;
