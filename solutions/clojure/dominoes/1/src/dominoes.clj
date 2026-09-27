(ns dominoes)

(defn can-chain?
  "Given a collection of dominoes, it returns true if they
  can be arranged into a chain; otherwise, it returns false."
  [dominoes]
  (if (empty? dominoes)
    true
    (let [degrees (reduce (fn [result [left right]]
                            (-> result
                                (update left (fnil inc 0))
                                (update right (fnil inc 0))))
                          {}
                          dominoes)
          vertices (set (keys degrees))
          odd-degree-count (count (filter odd? (vals degrees)))
          neighbors (fn [vertex]
                      (set (mapcat (fn [[left right]]
                                     (cond
                                       (= vertex left) [right]
                                       (= vertex right) [left]
                                       :else []))
                                   dominoes)))
          reachable (loop [pending [(first vertices)]
                           visited #{}]
                      (if (empty? pending)
                        visited
                        (let [vertex (first pending)
                              remaining (rest pending)]
                          (if (contains? visited vertex)
                            (recur remaining visited)
                            (recur (concat remaining (neighbors vertex))
                                   (conj visited vertex))))))]
      (boolean (and (or (zero? odd-degree-count) (= odd-degree-count 2))
                    (= vertices reachable))))))
