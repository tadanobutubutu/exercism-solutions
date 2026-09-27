(ns knapsack)

(defn maximum-value
  "Calculates the maximum value that can be packed."
  [maximum-weight items]
  (let [best-values (reduce (fn [values {:keys [weight value]}]
                              (if (> weight maximum-weight)
                                values
                                (reduce (fn [updated capacity]
                                          (assoc updated capacity
                                                 (max (nth updated capacity)
                                                      (+ (nth updated (- capacity weight)) value))))
                                        values
                                        (range maximum-weight (dec weight) -1))))
                            (vec (repeat (inc maximum-weight) 0))
                            items)]
    (apply max best-values)))
