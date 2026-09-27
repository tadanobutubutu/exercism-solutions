package bankaccount

import (
	"math"
	"sync"
)

type Account struct {
	mu      sync.Mutex
	balance int64
	open    bool
}

func Open(amt int64) *Account {
	if amt < 0 {
		return nil
	}
	return &Account{balance: amt, open: true}
}

func (a *Account) Balance() (bal int64, ok bool) {
	a.mu.Lock()
	defer a.mu.Unlock()
	if !a.open {
		return 0, false
	}
	return a.balance, true
}

func (a *Account) Deposit(amt int64) (newBal int64, ok bool) {
	a.mu.Lock()
	defer a.mu.Unlock()
	if !a.open || amt < -a.balance || (amt > 0 && a.balance > math.MaxInt64-amt) {
		return 0, false
	}
	a.balance += amt
	return a.balance, true
}

func (a *Account) Withdraw(amt int64) (newBal int64, ok bool) {
	a.mu.Lock()
	defer a.mu.Unlock()
	if !a.open || amt <= 0 || amt > a.balance {
		return 0, false
	}
	a.balance -= amt
	return a.balance, true
}

func (a *Account) Close() (pay int64, ok bool) {
	a.mu.Lock()
	defer a.mu.Unlock()
	if !a.open {
		return 0, false
	}
	pay = a.balance
	a.balance = 0
	a.open = false
	return pay, true
}
