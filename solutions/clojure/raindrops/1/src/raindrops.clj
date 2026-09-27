(ns raindrops)

(defn convert
  "Converts a number to its corresponding string of raindrop sounds."
  [num]
  (let [sounds (str (when (zero? (mod num 3)) "Pling")
                    (when (zero? (mod num 5)) "Plang")
                    (when (zero? (mod num 7)) "Plong"))]
    (if (empty? sounds) (str num) sounds)))
