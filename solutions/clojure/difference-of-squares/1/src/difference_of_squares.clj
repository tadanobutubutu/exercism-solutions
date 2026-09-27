(ns difference-of-squares)

(defn square-of-sum
  "Returns the square of the sum of the numbers up to N."
  [N]
  (let [sum (reduce + (range 1 (inc N)))]
    (* sum sum)))

(defn sum-of-squares
  "Returns the sum of the squares of the numbers up to N."
  [N]
  (reduce + (map #(* % %) (range 1 (inc N))))

(defn difference
  "Returns the difference between the square of the sum
  and the sum of the squares of the numbers up to N."
  [N]
  (- (square-of-sum N) (sum-of-squares N)))
