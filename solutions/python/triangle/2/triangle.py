def is_valid(sides):
    a, b, c = sides
    return all(s > 0 for s in sides) and a + b > c and a + c > b and b + c > a

def equilateral(sides):
    return is_valid(sides) and len(set(sides)) == 1

def isosceles(sides):
    return is_valid(sides) and len(set(sides)) <= 2

def scalene(sides):
    return is_valid(sides) and len(set(sides)) == 3
