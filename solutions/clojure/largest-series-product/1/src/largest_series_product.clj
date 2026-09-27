(ns largest-series-product)

(defn largest-product
  "Returns the largest product of any consecutive digits of length span
  in the string s."
  [span s]
  (cond
    (neg? span)
    (throw (IllegalArgumentException. "span must not be negative"))
    (> span (count s))
    (throw (IllegalArgumentException. "span must not exceed string length"))
    (not (re-matches #"[0-9]*" s))
    (throw (IllegalArgumentException. "digits input must only contain digits"))
    (zero? span) 1
    :else
    (let [digits (map #(- (int %) (int \0)) s)
          products (map #(reduce * %) (partition span 1 digits))]
      (apply max products)))
