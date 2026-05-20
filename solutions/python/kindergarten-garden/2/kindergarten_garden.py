class Garden:
    STUDENTS = ["Alice", "Bob", "Charlie", "David", "Eve", "Fred", "Ginny", "Harriet", "Ileana", "Joseph", "Kincaid", "Larry"]
    PLANTS = {'V': "Violets", 'R': "Radishes", 'C': "Clover", 'G': "Grass"}

    def __init__(self, diagram, students=None):
        if students is None:
            students = self.STUDENTS
        self.diagram = diagram.split("\n")
        self.students = sorted(students)

    def plants(self, student):
        student_index = self.students.index(student)
        result = []
        for row in range(2):
            for col in range(2):
                char = self.diagram[row][student_index * 2 + col]
                result.append(self.PLANTS[char])
        return result
