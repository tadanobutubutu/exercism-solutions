package customset

import (
	"sort"
	"strconv"
	"strings"
)

// Implement Set as a collection of unique string values.
//
// For Set.String, use '{' and '}', output elements as double-quoted strings
// safely escaped with Go syntax, and use a comma and a single space between
// elements. For example, a set with 2 elements, "a" and "b", should be formatted as {"a", "b"}.
// Format the empty set as {}.

type Set map[string]struct{}

func New() Set {
	return make(Set)
}

func NewFromSlice(l []string) Set {
	set := New()
	for _, elem := range l {
		set.Add(elem)
	}
	return set
}

func (s Set) String() string {
	elems := make([]string, 0, len(s))
	for elem := range s {
		elems = append(elems, elem)
	}
	sort.Strings(elems)
	quoted := make([]string, len(elems))
	for i, elem := range elems {
		quoted[i] = strconv.Quote(elem)
	}
	return "{" + strings.Join(quoted, ", ") + "}"
}

func (s Set) IsEmpty() bool {
	return len(s) == 0
}

func (s Set) Has(elem string) bool {
	_, ok := s[elem]
	return ok
}

func (s Set) Add(elem string) {
	s[elem] = struct{}{}
}

func Subset(s1, s2 Set) bool {
	for elem := range s1 {
		if !s2.Has(elem) {
			return false
		}
	}
	return true
}

func Disjoint(s1, s2 Set) bool {
	for elem := range s1 {
		if s2.Has(elem) {
			return false
		}
	}
	return true
}

func Equal(s1, s2 Set) bool {
	return len(s1) == len(s2) && Subset(s1, s2)
}

func Intersection(s1, s2 Set) Set {
	result := New()
	for elem := range s1 {
		if s2.Has(elem) {
			result.Add(elem)
		}
	}
	return result
}

func Difference(s1, s2 Set) Set {
	result := New()
	for elem := range s1 {
		if !s2.Has(elem) {
			result.Add(elem)
		}
	}
	return result
}

func Union(s1, s2 Set) Set {
	result := New()
	for elem := range s1 {
		result.Add(elem)
	}
	for elem := range s2 {
		result.Add(elem)
	}
	return result
}
