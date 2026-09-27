(ns series)

(defn slices
  "Returns all contiguous substrings of length n from the string s."
  [s n]
  (cond
    (empty? s) (throw (IllegalArgumentException. "series cannot be empty"))
    (neg? n) (throw (IllegalArgumentException. "slice length cannot be negative"))
    (zero? n) (throw (IllegalArgumentException. "slice length cannot be zero"))
    (> n (count s)) (throw (IllegalArgumentException. "slice length cannot be greater than series length"))
    :else (mapv #(subs s % (+ % n)) (range (inc (- (count s) n)))))
