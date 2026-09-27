local BankAccount = {}

function BankAccount:new()
  return setmetatable({ is_open = false, amount = 0 }, self)
end

function BankAccount:open()
  if self.is_open then error('account is already open') end
  self.is_open = true
  self.amount = 0
end

function BankAccount:close()
  if not self.is_open then error('account is not open') end
  self.is_open = false
  self.amount = 0
end

function BankAccount:balance()
  if not self.is_open then error('account is not open') end
  return self.amount
end

function BankAccount:deposit(amount)
  if not self.is_open then error('account is not open') end
  if amount < 0 then error('amount cannot be negative') end
  self.amount = self.amount + amount
end

function BankAccount:withdraw(amount)
  if not self.is_open then error('account is not open') end
  if amount < 0 then error('amount cannot be negative') end
  if amount > self.amount then error('insufficient funds') end
  self.amount = self.amount - amount
end

BankAccount.__index = BankAccount

return BankAccount
