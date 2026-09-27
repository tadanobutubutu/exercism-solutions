(ns perfect-numbers)

(defn classify
  "Classifies the given number as perfect, abundant, or deficient."
  [num]
  (let [aliquot-sum (if (<= num 1)
                      0
                      (loop [divisor 1
                             total 0]
                        (if (> (* divisor divisor) num)
                          total
                          (if (zero? (mod num divisor))
                            (let [paired (quot num divisor)
                                  addition (cond
                                             (= divisor paired) divisor
                                             (= paired num) divisor
                                             :else (+ divisor paired))]
                              (recur (inc divisor) (+ total addition)))
                            (recur (inc divisor) total)))))]
    (cond
      (= aliquot-sum num) :perfect
      (> aliquot-sum num) :abundant
      :else :deficient)))
