(ns flower-field)

(defn draw
  "Fills in the number of adjacent flowers for each empty square in the board."
  [board]
  (let [row-count (count board)
        column-count (if (zero? row-count) 0 (count (first board)))]
    (mapv (fn [row-index]
            (apply str
                   (for [column-index (range column-count)]
                     (let [square (get-in board [row-index column-index])]
                       (if (= square \*)
                         \*
                         (let [flower-count (count (for [row-offset [-1 0 1]
                                                         column-offset [-1 0 1]
                                                         :when (not (and (zero? row-offset)
                                                                         (zero? column-offset)))
                                                         :let [neighbor-row (+ row-index row-offset)
                                                               neighbor-column (+ column-index column-offset)]
                                                         :when (and (<= 0 neighbor-row)
                                                                    (< neighbor-row row-count)
                                                                    (<= 0 neighbor-column)
                                                                    (< neighbor-column column-count)
                                                                    (= \* (get-in board [neighbor-row neighbor-column])))]
                                                     1))]
                           (if (zero? flower-count)
                             \space
                             (char (+ (int \0) flower-count)))))))))
          (range row-count))))
