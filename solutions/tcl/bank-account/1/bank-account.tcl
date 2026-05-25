oo::class create BankAccount {
    variable balanceVar isOpen

    constructor {} {
        set isOpen false
        set balanceVar 0
    }

    method open {} {
        if {$isOpen} {
            error "account is already open"
        }
        set isOpen true
        set balanceVar 0
    }

    method close {} {
        if {!$isOpen} {
            error "account is not open"
        }
        set isOpen false
    }

    method balance {} {
        if {!$isOpen} {
            error "account is not open"
        }
        return $balanceVar
    }

    method deposit {amount} {
        if {!$isOpen} {
            error "account is not open"
        }
        if {$amount < 0} {
            error "invalid amount"
        }
        incr balanceVar $amount
    }

    method withdraw {amount} {
        if {!$isOpen} {
            error "account is not open"
        }
        if {$amount < 0} {
            error "invalid amount"
        }
        if {$amount > $balanceVar} {
            error "insufficient funds"
        }
        incr balanceVar -$amount
    }
}
