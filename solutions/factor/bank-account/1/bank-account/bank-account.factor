USING: accessors concurrency.locks kernel math typed ;
IN: bank-account

TUPLE: bank-account mutex open-state amount ;

: <bank-account> ( -- account: bank-account )
    bank-account new <lock> >>mutex f >>open-state 0 >>amount ;

TYPED:: open-account ( account: bank-account -- )
    account mutex>> [
        account open-state>> [ "account is already open" throw ] when
        account t >>open-state drop
        account 0 >>amount drop
    ] with-lock ;

TYPED:: close-account ( account: bank-account -- )
    account mutex>> [
        account open-state>> [ ] [ "account is not open" throw ] if
        account f >>open-state drop
        account 0 >>amount drop
    ] with-lock ;

TYPED:: balance ( account: bank-account -- n: integer )
    account mutex>> [
        account open-state>> [ account amount>> ] [ "account is not open" throw ] if
    ] with-lock ;

TYPED:: deposit ( amount: integer account: bank-account -- )
    account mutex>> [
        account open-state>> [ ] [ "account is not open" throw ] if
        amount 0 < [ "amount must not be negative" throw ] when
        account dup amount>> amount + >>amount drop
    ] with-lock ;

TYPED:: withdraw ( amount: integer account: bank-account -- )
    account mutex>> [
        account open-state>> [ ] [ "account is not open" throw ] if
        amount 0 < [ "amount must not be negative" throw ] when
        account amount>> amount < [ "insufficient funds" throw ] when
        account dup amount>> amount - >>amount drop
    ] with-lock ;
