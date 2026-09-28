abstract class Character
{
    private readonly string _characterType;

    protected Character(string characterType)
    {
        _characterType = characterType;
    }

    public abstract int DamagePoints(Character target);

    public virtual bool Vulnerable()
    {
        return false;
    }

    public override string ToString()
    {
        return $"Character is a {_characterType}";
    }
}

class Warrior : Character
{
    public Warrior() : base("Warrior")
    {
    }

    public override int DamagePoints(Character target)
    {
        return target.Vulnerable() ? 10 : 6;
    }
}

class Wizard : Character
{
    private bool _spellPrepared;

    public Wizard() : base("Wizard")
    {
    }

    public override int DamagePoints(Character target)
    {
        return _spellPrepared ? 12 : 3;
    }

    public override bool Vulnerable() => !_spellPrepared;

    public void PrepareSpell()
    {
        _spellPrepared = true;
    }
}
