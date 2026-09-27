(ns darts)

(defn score
  "Calculates the score of a dart throw."
  [x y]
  (let [distance-squared (+ (* x x) (* y y))]
    (cond
      (<= distance-squared 1) 10
      (<= distance-squared 25) 5
      (<= distance-squared 100) 1
      :else 0)))
