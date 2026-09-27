(ns collatz-conjecture)

(defn collatz
  "Returns the number of steps for num to reach 1
  according to the Collatz Conjecture."
  [num]
  (when-not (pos? num)
    (throw (IllegalArgumentException. "number must be positive")))
  (loop [current num
         steps 0]
    (if (= current 1)
      steps
      (recur (if (even? current)
               (quot current 2)
               (inc (*' current 3)))
             (inc steps))))
