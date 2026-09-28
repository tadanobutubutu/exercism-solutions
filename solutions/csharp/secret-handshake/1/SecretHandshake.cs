public static class SecretHandshake
{
    public static string[] Commands(int commandValue)
    {
        var commands = new List<string>();
        if ((commandValue & 1) != 0) commands.Add("wink");
        if ((commandValue & 2) != 0) commands.Add("double blink");
        if ((commandValue & 4) != 0) commands.Add("close your eyes");
        if ((commandValue & 8) != 0) commands.Add("jump");
        if ((commandValue & 16) != 0) commands.Reverse();

        return commands.ToArray();
    }
}
