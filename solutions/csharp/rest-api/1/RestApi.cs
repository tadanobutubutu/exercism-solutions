using System.Text.Json;
using System.Text.Json.Serialization;

public class RestApi
{
    private readonly List<User> _users;

    public RestApi(string database)
    {
        ArgumentNullException.ThrowIfNull(database);
        _users = JsonSerializer.Deserialize<List<User>>(database,
            new JsonSerializerOptions { PropertyNameCaseInsensitive = true }) ?? [];
    }

    public string Get(string url, string? payload = null)
    {
        if (url != "/users") throw new ArgumentException("Unknown endpoint.", nameof(url));

        IEnumerable<User> users = _users;
        if (payload is not null)
        {
            using JsonDocument request = JsonDocument.Parse(payload);
            HashSet<string> requested = request.RootElement.GetProperty("users")
                .EnumerateArray()
                .Select(item => item.GetString()!)
                .ToHashSet(StringComparer.Ordinal);
            users = users.Where(user => requested.Contains(user.Name));
        }

        return SerializeUsers(users.OrderBy(user => user.Name, StringComparer.Ordinal));
    }

    public string Post(string url, string payload)
    {
        ArgumentNullException.ThrowIfNull(payload);
        using JsonDocument request = JsonDocument.Parse(payload);

        if (url == "/add")
        {
            string name = request.RootElement.GetProperty("user").GetString()!;
            if (_users.Any(user => user.Name == name))
                throw new ArgumentException("The user already exists.", nameof(payload));
            var user = new User { Name = name };
            _users.Add(user);
            return JsonSerializer.Serialize(FormatUser(user));
        }

        if (url == "/iou")
        {
            string lenderName = request.RootElement.GetProperty("lender").GetString()!;
            string borrowerName = request.RootElement.GetProperty("borrower").GetString()!;
            decimal amount = request.RootElement.GetProperty("amount").GetDecimal();
            User lender = _users.Single(user => user.Name == lenderName);
            User borrower = _users.Single(user => user.Name == borrowerName);

            decimal existingDebt = GetAmount(lender.Owes, borrowerName);
            decimal remainingOldDebt = Math.Max(0m, existingDebt - amount);
            SetAmount(lender.Owes, borrowerName, remainingOldDebt);
            SetAmount(borrower.OwedBy, lenderName, remainingOldDebt);

            decimal excess = Math.Max(0m, amount - existingDebt);
            if (excess > 0)
            {
                SetAmount(lender.OwedBy, borrowerName, GetAmount(lender.OwedBy, borrowerName) + excess);
                SetAmount(borrower.Owes, lenderName, GetAmount(borrower.Owes, lenderName) + excess);
            }

            lender.Balance = Balance(lender);
            borrower.Balance = Balance(borrower);
            return SerializeUsers(new[] { lender, borrower }.OrderBy(user => user.Name, StringComparer.Ordinal));
        }

        throw new ArgumentException("Unknown endpoint.", nameof(url));
    }

    private static decimal GetAmount(Dictionary<string, decimal> amounts, string name) =>
        amounts.TryGetValue(name, out decimal amount) ? amount : 0m;

    private static void SetAmount(Dictionary<string, decimal> amounts, string name, decimal amount)
    {
        if (amount == 0m) amounts.Remove(name);
        else amounts[name] = amount;
    }

    private static decimal Balance(User user) => user.OwedBy.Values.Sum() - user.Owes.Values.Sum();

    private static string SerializeUsers(IEnumerable<User> users) =>
        JsonSerializer.Serialize(users.Select(FormatUser).ToArray());

    private static object FormatUser(User user) => new
    {
        name = user.Name,
        owes = Sorted(user.Owes),
        owed_by = Sorted(user.OwedBy),
        balance = Balance(user)
    };

    private static Dictionary<string, decimal> Sorted(Dictionary<string, decimal> amounts) =>
        amounts.OrderBy(pair => pair.Key, StringComparer.Ordinal)
            .ToDictionary(pair => pair.Key, pair => pair.Value, StringComparer.Ordinal);

    private sealed class User
    {
        public string Name { get; set; } = string.Empty;
        public Dictionary<string, decimal> Owes { get; set; } = new(StringComparer.Ordinal);
        [JsonPropertyName("owed_by")]
        public Dictionary<string, decimal> OwedBy { get; set; } = new(StringComparer.Ordinal);
        public decimal Balance { get; set; }
    }
}
