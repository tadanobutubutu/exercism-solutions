public class Robot
{
    private static readonly HashSet<string> UsedNames = new(StringComparer.Ordinal);
    private string? _name;

    public string Name
    {
        get
        {
            if (_name is null)
            {
                lock (UsedNames)
                {
                    _name ??= CreateUniqueName();
                }
            }

            return _name;
        }
    }

    public void Reset()
    {
        lock (UsedNames)
        {
            _name = CreateUniqueName();
        }
    }

    private static string CreateUniqueName()
    {
        while (true)
        {
            var name = string.Concat(
                (char)('A' + System.Security.Cryptography.RandomNumberGenerator.GetInt32(26)),
                (char)('A' + System.Security.Cryptography.RandomNumberGenerator.GetInt32(26)),
                System.Security.Cryptography.RandomNumberGenerator.GetInt32(1000).ToString("D3"));

            if (UsedNames.Add(name))
            {
                return name;
            }
        }
    }
}
