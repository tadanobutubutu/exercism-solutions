(ns eliuds-eggs)

(defn egg-count
  "Returns the number of 1 bits in the binary representation of the given number."
  [num]
  (loop [remaining num
         count 0]
    (if (zero? remaining)
      count
      (recur (quot remaining 2) (+ count (mod remaining 2)))))
