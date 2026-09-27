(ns triangle)

(defn- valid-triangle? [a b c]
  (and (pos? a) (pos? b) (pos? c)
       (>= (+ a b) c)
       (>= (+ a c) b)
       (>= (+ b c) a)))

(defn equilateral?
  "Returns true if the triangle with sides a, b, and c is equilateral;
  otherwise, it returns false."
  [a b c]
  (and (valid-triangle? a b c) (= a b c)))

(defn isosceles?
  "Returns true if the triangle with sides a, b, and c is isosceles;
  otherwise, it returns false."
  [a b c]
  (and (valid-triangle? a b c)
       (or (= a b) (= a c) (= b c))))

(defn scalene?
  "Returns true if the triangle with sides a, b, and c is scalene;
  otherwise, it returns false."
  [a b c]
  (and (valid-triangle? a b c)
       (not= a b) (not= a c) (not= b c)))
