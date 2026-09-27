(ns game-of-life)

(defn tick
  "Returns the next generation of the cells."
  [cells]
  (let [row-count (count cells)
        column-count (if (zero? row-count) 0 (count (first cells)))]
    (mapv (fn [row-index]
            (mapv (fn [column-index]
                    (let [neighbors (for [row-offset [-1 0 1]
                                          column-offset [-1 0 1]
                                          :when (not (and (zero? row-offset)
                                                          (zero? column-offset)))
                                          :let [neighbor-row (+ row-index row-offset)
                                                neighbor-column (+ column-index column-offset)]
                                          :when (and (<= 0 neighbor-row)
                                                     (< neighbor-row row-count)
                                                     (<= 0 neighbor-column)
                                                     (< neighbor-column column-count)
                                                     (= 1 (get-in cells [neighbor-row neighbor-column])))]
                                      1)
                          alive? (= 1 (get-in cells [row-index column-index]))]
                      (if (or (= (count neighbors) 3)
                              (and alive? (= (count neighbors) 2)))
                        1
                        0)))
                  (range column-count)))
          (range row-count))))
