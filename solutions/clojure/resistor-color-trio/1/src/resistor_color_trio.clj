(ns resistor-color-trio)

(def color-values
  {"black" 0, "brown" 1, "red" 2, "orange" 3, "yellow" 4,
   "green" 5, "blue" 6, "violet" 7, "grey" 8, "white" 9})

(defn- decimal-string [number]
  (.toPlainString (.stripTrailingZeros (bigdec number))))

(defn resistor-label
  "Returns the resistor label based on the given color bands."
  [colors]
  (let [[first-color second-color third-color] colors
        value (* (+ (* 10 (get color-values first-color))
                    (get color-values second-color))
                 (reduce * 1 (repeat (get color-values third-color) 10)))]
    (cond
      (< value 1000) (str value " ohms")
      (< value 1000000) (str (decimal-string (/ (bigdec value) 1000M)) " kiloohms")
      (< value 1000000000) (str (decimal-string (/ (bigdec value) 1000000M)) " megaohms")
      :else (str (decimal-string (/ (bigdec value) 1000000000M)) " gigaohms")))
