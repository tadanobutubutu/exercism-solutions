def can_chain(dominoes):
    """Check if dominoes can form a chain."""
    if not dominoes:
        return []
    
    # Build adjacency list and degree count
    from collections import defaultdict
    graph = defaultdict(list)
    degree = defaultdict(int)
    
    for i, (a, b) in enumerate(dominoes):
        graph[a].append((b, i, 0))  # (to, index, direction: 0=normal)
        if a != b:
            graph[b].append((a, i, 1))  # (to, index, direction: 1=reversed)
            degree[a] += 1
            degree[b] += 1
        else:
            # Self-loop: counts as 2 degrees
            degree[a] += 2
    
    # Check Eulerian cycle conditions
    # All vertices must have even degree
    odd_vertices = [v for v in degree if degree[v] % 2 == 1]
    
    if len(odd_vertices) != 0:
        return None
    
    # DFS to find Eulerian cycle
    if not dominoes:
        return []
    
    start = dominoes[0][0]
    
    used = [False] * len(dominoes)
    path = []
    
    def dfs(v):
        for i, (to, idx, direction) in enumerate(graph[v]):
            if not used[idx]:
                used[idx] = True
                dfs(to)
                if direction == 0:
                    path.append(dominoes[idx])
                else:
                    path.append((dominoes[idx][1], dominoes[idx][0]))
    
    dfs(start)
    
    # Check if all dominoes were used and form a valid cycle
    if len(path) != len(dominoes):
        return None
    
    return list(reversed(path))
