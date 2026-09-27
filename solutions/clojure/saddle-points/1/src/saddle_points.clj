(ns saddle-points)

(defn saddle-points
  "Returns the saddle points of a matrix."
  [matrix]
  (let [matrix (mapv vec matrix)]
    (if (empty? matrix)
      #{}
      (let [column-minima (mapv #(apply min %) (apply map vector matrix))]
        (into #{}
              (for [row-index (range (count matrix))
                    column-index (range (count (first matrix)))
                    :let [row (nth matrix row-index)
                          value (nth row column-index)]
                    :when (and (= value (apply max row))
                               (= value (nth column-minima column-index)))]
                [(inc row-index) (inc column-index)])))))
