static class Badge
{
    public static string Print(int? id, string name, string? department)
    {
        var idPrefix = id.HasValue ? $"[{id.Value}] - " : string.Empty;
        var departmentName = (department ?? "OWNER").ToUpperInvariant();
        return $"{idPrefix}{name} - {departmentName}";
    }
}
