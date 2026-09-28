public class Authenticator
{
    private static class EyeColor
    {
        public const string Blue = "blue";
        public const string Green = "green";
        public const string Brown = "brown";
        public const string Hazel = "hazel";
        public const string Grey = "grey";
    }

    public Authenticator(Identity admin)
    {
        this.admin = admin;
    }

    private readonly Identity admin;

    private readonly Dictionary<string, Identity> developers = new()
        {
            ["Bertrand"] = new Identity
            {
                Email = "bert@ex.ism",
                EyeColor = "blue"
            },

            ["Anders"] = new Identity
            {
                Email = "anders@ex.ism",
                EyeColor = "brown"
            }
        };

    public Identity Admin
    {
        get => admin;
    }

    public IDictionary<string, Identity> GetDevelopers() =>
        new System.Collections.ObjectModel.ReadOnlyDictionary<string, Identity>(developers);
}

public struct Identity
{
    public string Email { get; set; }

    public string EyeColor { get; set; }
}
