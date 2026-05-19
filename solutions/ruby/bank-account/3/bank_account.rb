class BankAccount
  def initialize
    @balance = 0
    @open = false
    @mutex = Mutex.new
  end

  def open
    @mutex.synchronize do
      raise ArgumentError, "You can't open an already open account" if @open
      @balance = 0
      @open = true
    end
  end

  def close
    @mutex.synchronize do
      raise ArgumentError, "You can't close an already closed account" unless @open
      @open = false
    end
  end

  def balance
    @mutex.synchronize do
      raise ArgumentError, "You can't check the balance of a closed account" unless @open
      @balance
    end
  end

  def deposit(amount)
    @mutex.synchronize do
      raise ArgumentError, "You can't deposit money into a closed account" unless @open
      raise ArgumentError, "You can't deposit a negative amount" if amount < 0
      @balance += amount
    end
  end

  def withdraw(amount)
    @mutex.synchronize do
      raise ArgumentError, "You can't withdraw money into a closed account" unless @open
      raise ArgumentError, "You can't withdraw a negative amount" if amount < 0
      raise ArgumentError, "You can't withdraw more than you have" if amount > @balance
      @balance -= amount
    end
  end
end
