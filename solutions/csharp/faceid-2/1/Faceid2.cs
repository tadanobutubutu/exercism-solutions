public class FacialFeatures : IEquatable<FacialFeatures>
{
    public string EyeColor { get; }
    public decimal PhiltrumWidth { get; }

    public FacialFeatures(string eyeColor, decimal philtrumWidth)
    {
        EyeColor = eyeColor;
        PhiltrumWidth = philtrumWidth;
    }
    public bool Equals(FacialFeatures? other) =>
        other is not null && EyeColor == other.EyeColor && PhiltrumWidth == other.PhiltrumWidth;

    public override bool Equals(object? obj) => obj is FacialFeatures other && Equals(other);

    public override int GetHashCode() => HashCode.Combine(EyeColor, PhiltrumWidth);
}

public class Identity : IEquatable<Identity>
{
    public string Email { get; }
    public FacialFeatures FacialFeatures { get; }

    public Identity(string email, FacialFeatures facialFeatures)
    {
        Email = email;
        FacialFeatures = facialFeatures;
    }
    public bool Equals(Identity? other) =>
        other is not null && Email == other.Email && FacialFeatures.Equals(other.FacialFeatures);

    public override bool Equals(object? obj) => obj is Identity other && Equals(other);

    public override int GetHashCode() => HashCode.Combine(Email, FacialFeatures);
}

public class Authenticator
{
    private readonly HashSet<Identity> registeredIdentities = new();

    public static bool AreSameFace(FacialFeatures faceA, FacialFeatures faceB)
    {
        return faceA.Equals(faceB);
    }

    public bool IsAdmin(Identity identity)
    {
        var admin = new Identity("admin@exerc.ism", new FacialFeatures("green", 0.9m));
        return identity.Equals(admin);
    }

    public bool Register(Identity identity)
    {
        return registeredIdentities.Add(identity);
    }

    public bool IsRegistered(Identity identity)
    {
        return registeredIdentities.Contains(identity);
    }

    public static bool AreSameObject(Identity identityA, Identity identityB)
    {
        return ReferenceEquals(identityA, identityB);
    }
}
