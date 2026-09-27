(ns killer-sudoku-helper)

(defn combinations
  "Returns the valid combinations for a given cage."
  [cage]
  (let [{:keys [sum size exclude]} cage
        excluded (set exclude)]
    (->> (range 512)
         (keep (fn [mask]
                 (let [digits (vec (for [index (range 9)
                                         :when (bit-test mask index)]
                                     (inc index)))]
                   (when (and (= size (count digits))
                              (= sum (reduce + digits))
                              (empty? (filter excluded digits)))
                     digits))))
         sort
         vec)))
