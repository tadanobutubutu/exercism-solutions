public class GradeSchool
{
    private readonly SortedDictionary<int, SortedSet<string>> _students = new();
    private readonly HashSet<string> _enrolled = new(StringComparer.Ordinal);

    public bool Add(string student, int grade)
    {
        if (!_enrolled.Add(student))
        {
            return false;
        }

        if (!_students.TryGetValue(grade, out var students))
        {
            students = new SortedSet<string>(StringComparer.Ordinal);
            _students[grade] = students;
        }

        students.Add(student);
        return true;
    }

    public IEnumerable<string> Roster()
    {
        return _students.Values.SelectMany(students => students).ToArray();
    }

    public IEnumerable<string> Grade(int grade)
    {
        return _students.TryGetValue(grade, out var students)
            ? students.ToArray()
            : Array.Empty<string>();
    }
}
