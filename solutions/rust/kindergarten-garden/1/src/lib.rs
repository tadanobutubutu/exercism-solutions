pub fn plants(diagram: &str, student: &str) -> Vec<&'static str> {
    const STUDENTS: [&str; 12] = [
        "Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny", "Harriet", "Ileana",
        "Joseph", "Kincaid", "Larry",
    ];
    let start = STUDENTS.iter().position(|name| *name == student).unwrap_or(0) * 2;
    let rows: Vec<&str> = diagram.lines().collect();
    let plant_name = |plant| match plant {
        'V' => "violets",
        'R' => "radishes",
        'C' => "clover",
        'G' => "grass",
        _ => "",
    };

    (0..2)
        .flat_map(|row| {
            rows.get(row)
                .and_then(|line| line.chars().skip(start).take(2).next())
                .into_iter()
                .chain(
                    rows.get(row)
                        .and_then(|line| line.chars().skip(start + 1).next()),
                )
                .map(plant_name)
        })
        .collect()
}
