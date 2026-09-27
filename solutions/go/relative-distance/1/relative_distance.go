package relativedistance

func DegreeOfSeparation(familyTree map[string][]string, personA, personB string) (int, bool) {
	graph := make(map[string][]string)
	people := make(map[string]struct{})
	for parent, children := range familyTree {
		people[parent] = struct{}{}
		for _, child := range children {
			people[child] = struct{}{}
			graph[parent] = append(graph[parent], child)
			graph[child] = append(graph[child], parent)
		}
	}
	if _, ok := people[personA]; !ok {
		return 0, false
	}
	if _, ok := people[personB]; !ok {
		return 0, false
	}
	if personA == personB {
		return 0, true
	}

	distance := map[string]int{personA: 0}
	queue := []string{personA}
	for len(queue) > 0 {
		person := queue[0]
		queue = queue[1:]
		for _, relative := range graph[person] {
			if _, visited := distance[relative]; visited {
				continue
			}
			distance[relative] = distance[person] + 1
			if relative == personB {
				return distance[relative], true
			}
			queue = append(queue, relative)
		}
	}
	return 0, false
}
