(ns yacht)

(defn score
  "Given five dice and a category, it returns the score of the dice
  for that category."
  [dice category]
  (let [counts (frequencies dice)
        total (reduce + dice)]
    (cond
      (contains? #{"ones" "twos" "threes" "fours" "fives" "sixes"} category)
      (let [face (inc (.indexOf ["ones" "twos" "threes" "fours" "fives" "sixes"] category))]
        (* face (get counts face 0)))

      (= category "full house")
      (if (= [2 3] (sort (vals counts))) total 0)

      (= category "four of a kind")
      (if-let [[face _] (first (filter (fn [[_ count]] (>= count 4)) counts))]
        (* face 4)
        0)

      (= category "little straight")
      (if (= (set dice) #{1 2 3 4 5}) 30 0)

      (= category "big straight")
      (if (= (set dice) #{2 3 4 5 6}) 30 0)

      (= category "choice") total
      (= category "yacht") (if (= 1 (count counts)) 50 0)
      :else 0)))
