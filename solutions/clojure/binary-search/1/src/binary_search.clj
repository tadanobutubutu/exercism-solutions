(ns binary-search)

(defn search-for
  "Returns the index of num in coll, or -1 if num is not found."
  [num coll]
  (loop [low 0
         high (dec (count coll))]
    (if (> low high)
      -1
      (let [middle (quot (+ low high) 2)
            value (nth coll middle)]
        (cond
          (= value num) middle
          (< value num) (recur (inc middle) high)
          :else (recur low (dec middle))))))
