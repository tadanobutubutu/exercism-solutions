(ns square-root)

(defn square-root
  "Calculates the square root of a number."
  [num]
  (loop [low 1
         high num]
    (let [mid (quot (+ low high) 2)
          square (*' mid mid)]
      (cond
        (= square num) mid
        (< square num) (recur (inc mid) high)
        :else (recur low (dec mid)))))
