(ns roman-numerals)

(def roman-values
  [[1000 "M"] [900 "CM"] [500 "D"] [400 "CD"]
   [100 "C"] [90 "XC"] [50 "L"] [40 "XL"]
   [10 "X"] [9 "IX"] [5 "V"] [4 "IV"] [1 "I"]])

(defn numerals
  "Converts a number to its roman numeral(s)."
  [num]
  (loop [remaining num
         values roman-values
         result []]
    (if (zero? remaining)
      (apply str result)
      (let [[value numeral] (first values)]
        (if (>= remaining value)
          (recur (- remaining value) values (conj result numeral))
          (recur remaining (rest values) result)))))
