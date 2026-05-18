class Garden:
    PLANTS = {
        'V': 'Violets',
        'R': 'Radishes',
        'C': 'Clover',
        'G': 'Grass'
    }
    
    DEFAULT_STUDENTS = [
        "Alice", "Bob", "Charlie", "David",
        "Eve", "Fred", "Ginny", "Harriet",
        "Ileana", "Joseph", "Kincaid", "Larry"
    ]

    def __init__(self, diagram, students=None):
        if students is None:
            students = self.DEFAULT_STUDENTS
        self.students = sorted(students)
        self.rows = diagram.split('\n')

    def plants(self, student):
        index = self.students.index(student) * 2
        res = []
        for row in self.rows:
            res.append(self.PLANTS[row[index]])
            res.append(self.PLANTS[row[index+1]])
        return res
