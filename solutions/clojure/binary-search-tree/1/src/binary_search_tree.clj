(ns binary-search-tree)

(defn value [tree]
  (first tree))

(defn singleton [value]
  [value nil nil])

(defn insert [value tree]
  (if (nil? tree)
    (singleton value)
    (let [[node-value left-child right-child] tree]
      (if (<= value node-value)
        [node-value (insert value left-child) right-child]
        [node-value left-child (insert value right-child)]))))

(defn left [tree]
  (second tree))

(defn right [tree]
  (nth tree 2))

(defn to-list [tree]
  (if (nil? tree)
    []
    (concat (to-list (left tree)) [ (value tree) ] (to-list (right tree)))))

(defn from-list [values]
  (reduce (fn [tree item] (insert item tree)) nil values))
