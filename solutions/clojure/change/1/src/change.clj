(ns change)

(defn issue
  "Given an amount to change and a set of coins, it returns the fewest coins
  such that the sum of their values equals the change."
  [amount coins]
  (when (neg? amount)
    (throw (IllegalArgumentException. "target can't be negative")))
  (if (zero? amount)
    '()
    (let [available (vec (sort (filter pos? coins)))
          unreachable (inc amount)
          initial-counts (assoc (vec (repeat (inc amount) unreachable)) 0 0)
          initial-coins (vec (repeat (inc amount) nil))
          [counts previous-coins]
          (loop [value 1
                 counts initial-counts
                 previous-coins initial-coins]
            (if (> value amount)
              [counts previous-coins]
              (let [candidates (for [coin available
                                     :when (<= coin value)
                                     :let [prior (nth counts (- value coin))]
                                     :when (< prior unreachable)]
                                 [(inc prior) coin])
                    best (first (sort-by first candidates))]
                (if best
                  (recur (inc value)
                         (assoc counts value (first best))
                         (assoc previous-coins value (second best)))
                  (recur (inc value) counts previous-coins)))))]
      (when (= unreachable (nth counts amount))
        (throw (IllegalArgumentException. "can't make target with given coins")))
      (loop [remaining amount
             result '()]
        (if (zero? remaining)
          (apply list (sort result))
          (let [coin (nth previous-coins remaining)]
            (recur (- remaining coin) (conj result coin)))))))
