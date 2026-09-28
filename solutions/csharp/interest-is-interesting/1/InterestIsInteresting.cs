static class SavingsAccount
{
    public static float InterestRate(decimal balance)
    {
        if (balance < 0m) return 3.213f;
        if (balance < 1_000m) return 0.5f;
        if (balance < 5_000m) return 1.621f;
        return 2.475f;
    }

    public static decimal Interest(decimal balance)
    {
        return balance * (decimal)InterestRate(balance) / 100m;
    }

    public static decimal AnnualBalanceUpdate(decimal balance)
    {
        return balance + Interest(balance);
    }

    public static int YearsBeforeDesiredBalance(decimal balance, decimal targetBalance)
    {
        var years = 0;
        while (balance < targetBalance)
        {
            balance = AnnualBalanceUpdate(balance);
            years++;
        }
        return years;
    }
}
