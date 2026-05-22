from collections import deque
from math import gcd


def measure(bucket_one, bucket_two, goal, start_bucket):
    """Measure exact amount using two buckets with BFS.
    
    Args:
        bucket_one: Size of bucket one
        bucket_two: Size of bucket two
        goal: Desired amount to measure
        start_bucket: Which bucket to fill first ("one" or "two")
    
    Returns:
        Tuple of (num_actions, bucket_with_goal, other_bucket_amount)
    
    Raises:
        ValueError: If goal is impossible to reach
    """
    # Goal must be achievable - check using GCD property
    if goal > max(bucket_one, bucket_two):
        raise ValueError("Goal is larger than both buckets")
    
    if gcd(bucket_one, bucket_two) != 1 and goal % gcd(bucket_one, bucket_two) != 0:
        raise ValueError("Goal is not achievable with these bucket sizes")
    
    # Initial state: fill the starting bucket
    if start_bucket == "one":
        initial_state = (bucket_one, 0)
        start_id = "one"
    else:
        initial_state = (0, bucket_two)
        start_id = "two"
    
    # BFS to find shortest path
    queue = deque([(initial_state, 1)])  # (state, num_actions)
    visited = {initial_state}
    
    while queue:
        (b1, b2), actions = queue.popleft()
        
        # Check if goal reached
        if b1 == goal:
            return (actions, "one", b2)
        if b2 == goal:
            return (actions, "two", b1)
        
        # Generate all possible next states
        next_states = []
        
        # Action 1: Empty bucket one
        next_states.append((0, b2))
        
        # Action 2: Empty bucket two
        next_states.append((b1, 0))
        
        # Action 3: Fill bucket one
        next_states.append((bucket_one, b2))
        
        # Action 4: Fill bucket two
        next_states.append((b1, bucket_two))
        
        # Action 5: Pour bucket one into bucket two
        pour_amount = min(b1, bucket_two - b2)
        next_states.append((b1 - pour_amount, b2 + pour_amount))
        
        # Action 6: Pour bucket two into bucket one
        pour_amount = min(b2, bucket_one - b1)
        next_states.append((b1 + pour_amount, b2 - pour_amount))
        
        for state in next_states:
            if state not in visited:
                # Check the constraint: can't end with starting bucket empty and other full
                if start_bucket == "one" and state != (0, bucket_two):
                    visited.add(state)
                    queue.append((state, actions + 1))
                elif start_bucket == "two" and state != (bucket_one, 0):
                    visited.add(state)
                    queue.append((state, actions + 1))
    
    raise ValueError("Goal is not achievable")
