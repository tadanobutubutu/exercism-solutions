(ns all-your-base)

(defn convert [input-base digits output-base]
  (if (and (> input-base 1)
           (> output-base 1)
           (every? #(and (integer? %) (<= 0 %) (< % input-base)) digits))
    (if (empty? digits)
      '()
      (let [decimal (reduce (fn [total digit]
                              (+ (* total input-base) digit))
                            0
                            digits)]
        (if (zero? decimal)
          '(0)
          (loop [remaining decimal
                 result '()]
            (if (zero? remaining)
              result
              (recur (quot remaining output-base)
                     (conj result (mod remaining output-base)))))))
    nil))
