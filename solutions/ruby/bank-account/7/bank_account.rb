class BankAccount
  def initialize
    @balance = 0
    @opened = false
    @lock = Mutex.new
  end

  def open
    @lock.synchronize do
      raise ArgumentError, "You can't open an already open account" if @opened
      @balance = 0
      @opened = true
    end
  end

  def close
    @lock.synchronize do
      raise ArgumentError, "You can't close an already closed account" unless @opened
      @opened = false
    end
  end

  def balance
    @lock.synchronize do
      raise ArgumentError, "You can't check the balance of a closed account" unless @opened
      @balance
    end
  end

  def deposit(amount)
    @lock.synchronize do
      raise ArgumentError, "You can't deposit money into a closed account" unless @opened
      raise ArgumentError, "You can't deposit a negative amount" if amount < 0
      @balance += amount
    end
  end

  def withdraw(amount)
    @lock.synchronize do
      raise ArgumentError, "You can't withdraw money into a closed account" unless @opened
      raise ArgumentError, "You can't withdraw a negative amount" if amount < 0
      raise ArgumentError, "You can't withdraw more than you have" if amount > @balance
      @balance -= amount
    end
  end
end
