(ns flatten-array)

(defn flatten
  "Flattens the given sequential collection.
  Nil values are excluded from the result."
  [coll]
  (vec (filter #(and (some? %) (not (sequential? %)))
               (tree-seq sequential? seq coll)))
