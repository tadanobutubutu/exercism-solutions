public struct CurrencyAmount : IEquatable<CurrencyAmount>
{
    private decimal amount;
    private string currency;

    public CurrencyAmount(decimal amount, string currency)
    {
        this.amount = amount;
        this.currency = currency;
    }

    public static bool operator ==(CurrencyAmount left, CurrencyAmount right)
    {
        EnsureSameCurrency(left, right);
        return left.amount == right.amount;
    }

    public static bool operator !=(CurrencyAmount left, CurrencyAmount right) => !(left == right);

    public static bool operator <(CurrencyAmount left, CurrencyAmount right)
    {
        EnsureSameCurrency(left, right);
        return left.amount < right.amount;
    }

    public static bool operator >(CurrencyAmount left, CurrencyAmount right)
    {
        EnsureSameCurrency(left, right);
        return left.amount > right.amount;
    }

    public static CurrencyAmount operator +(CurrencyAmount left, CurrencyAmount right)
    {
        EnsureSameCurrency(left, right);
        return new CurrencyAmount(left.amount + right.amount, left.currency);
    }

    public static CurrencyAmount operator -(CurrencyAmount left, CurrencyAmount right)
    {
        EnsureSameCurrency(left, right);
        return new CurrencyAmount(left.amount - right.amount, left.currency);
    }

    public static CurrencyAmount operator *(CurrencyAmount amount, decimal factor) =>
        new(amount.amount * factor, amount.currency);

    public static CurrencyAmount operator *(decimal factor, CurrencyAmount amount) => amount * factor;

    public static CurrencyAmount operator /(CurrencyAmount amount, decimal divisor) =>
        new(amount.amount / divisor, amount.currency);

    public static explicit operator double(CurrencyAmount amount) => (double)amount.amount;

    public static implicit operator decimal(CurrencyAmount amount) => amount.amount;

    public bool Equals(CurrencyAmount other) => this == other;

    public override bool Equals(object? obj) => obj is CurrencyAmount other && Equals(other);

    public override int GetHashCode() => HashCode.Combine(amount, currency);

    private static void EnsureSameCurrency(CurrencyAmount left, CurrencyAmount right)
    {
        if (!string.Equals(left.currency, right.currency, StringComparison.Ordinal))
        {
            throw new ArgumentException("Currency amounts must use the same currency.");
        }
    }
}
