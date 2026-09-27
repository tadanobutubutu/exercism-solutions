package gradeschool

import "sort"

type School struct {
	grades   map[int][]string
	students map[string]struct{}
}

func New() *School {
	return &School{
		grades:   make(map[int][]string),
		students: make(map[string]struct{}),
	}
}

func (s *School) Add(student string, grade int) bool {
	if _, exists := s.students[student]; exists {
		return false
	}
	s.students[student] = struct{}{}
	s.grades[grade] = append(s.grades[grade], student)
	return true
}

func (s *School) Grade(level int) []string {
	students := append([]string{}, s.grades[level]...)
	sort.Strings(students)
	return students
}

func (s *School) Enrollment() []string {
	levels := make([]int, 0, len(s.grades))
	for level := range s.grades {
		levels = append(levels, level)
	}
	sort.Ints(levels)

	enrollment := make([]string, 0, len(s.students))
	for _, level := range levels {
		students := s.Grade(level)
		enrollment = append(enrollment, students...)
	}
	return enrollment
}
