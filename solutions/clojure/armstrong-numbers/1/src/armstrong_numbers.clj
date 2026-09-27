(ns armstrong-numbers)

(defn armstrong?
  "Returns true if the given number is an Armstrong number;
  otherwise, it returns false."
  [num]
  (let [digits (map #(- (int %) (int \0)) (str num))
        power (count digits)]
    (= num (reduce + (map (fn [digit]
                            (reduce * 1 (repeat power digit)))
                          digits))))
