(ns hamming)

(defn distance
  "Returns the hamming distance between two DNA strands."
  [strand1 strand2]
  (when (not= (count strand1) (count strand2))
    (throw (IllegalArgumentException. "strands must be of equal length")))
  (count (filter false? (map = strand1 strand2))))
