class School:
    def __init__(self):
        self.students = {}
        self._added_status = []

    def add_student(self, name, grade):
        if name in self.students:
            self._added_status.append(False)
            return
        self.students[name] = grade
        self._added_status.append(True)

    def roster(self):
        sorted_names = sorted(self.students.keys(), key=lambda x: (self.students[x], x))
        return sorted_names

    def grade(self, grade_number):
        return sorted([name for name, g in self.students.items() if g == grade_number])

    def added(self):
        return self._added_status
