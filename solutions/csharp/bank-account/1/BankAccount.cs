public class BankAccount
{
    private readonly object sync = new();
    private decimal balance;
    private bool isOpen;

    public void Open()
    {
        lock (sync)
        {
            if (isOpen)
            {
                throw new InvalidOperationException("The account is already open.");
            }

            balance = 0m;
            isOpen = true;
        }
    }

    public void Close()
    {
        lock (sync)
        {
            EnsureOpen();
            isOpen = false;
        }
    }

    public decimal Balance
    {
        get
        {
            lock (sync)
            {
                EnsureOpen();
                return balance;
            }
        }
    }

    public void Deposit(decimal change)
    {
        lock (sync)
        {
            EnsureOpen();
            if (change < 0)
            {
                throw new InvalidOperationException("A deposit cannot be negative.");
            }
            balance += change;
        }
    }

    public void Withdraw(decimal change)
    {
        lock (sync)
        {
            EnsureOpen();
            if (change < 0 || change > balance)
            {
                throw new InvalidOperationException("The withdrawal amount is invalid.");
            }
            balance -= change;
        }
    }

    private void EnsureOpen()
    {
        if (!isOpen)
        {
            throw new InvalidOperationException("The account is not open.");
        }
    }
}
