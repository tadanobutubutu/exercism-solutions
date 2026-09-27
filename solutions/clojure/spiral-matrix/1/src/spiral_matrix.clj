(ns spiral-matrix)

(defn spiral
  "Returns a spiral matrix of size n x n."
  [n]
  (let [empty-matrix (vec (repeat n (vec (repeat n 0))))
        layers (range (quot (inc n) 2))
        coordinates (mapcat (fn [layer]
                              (let [top layer
                                    left layer
                                    bottom (- n layer 1)
                                    right (- n layer 1)]
                                (concat
                                 (for [column (range left (inc right))] [top column])
                                 (for [row (range (inc top) (inc bottom))] [row right])
                                 (for [column (range (dec right) (dec left) -1)] [bottom column])
                                 (for [row (range (dec bottom) top -1)] [row left]))))
                            layers)]
    (first
     (reduce (fn [[matrix value] [row column]]
               [(assoc-in matrix [row column] value) (inc value)])
             [empty-matrix 1]
             coordinates))))
