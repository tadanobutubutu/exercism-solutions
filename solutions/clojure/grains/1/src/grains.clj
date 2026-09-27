(ns grains)

(defn square
  "Returns the number of grains on the n-th chessboard square."
  [n]
  (reduce *' 1N (repeat (dec n) 2N)))

(defn total
  "Returns the total number of grains on the chessboard."
  []
  (dec (square 65)))
