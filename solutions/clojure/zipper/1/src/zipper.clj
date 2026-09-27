(ns zipper)

(defn from-tree [tree]
  {:focus tree :path []})

(defn value [zipper]
  (get-in zipper [:focus :value]))

(defn left [zipper]
  (when-let [tree (:focus zipper)]
    (when-let [child (:left tree)]
      {:focus child
       :path (conj (:path zipper)
                   {:value (:value tree) :side :left :sibling (:right tree)})})))

(defn right [zipper]
  (when-let [tree (:focus zipper)]
    (when-let [child (:right tree)]
      {:focus child
       :path (conj (:path zipper)
                   {:value (:value tree) :side :right :sibling (:left tree)})})))

(defn up [zipper]
  (when-let [path (:path zipper)]
    (when (seq path)
      (let [{:keys [value side sibling]} (peek path)
            parent (if (= side :left)
                     {:value value :left (:focus zipper) :right sibling}
                     {:value value :left sibling :right (:focus zipper)})]
        {:focus parent :path (pop path)}))))

(defn to-tree [zipper]
  (when zipper
    (loop [current zipper]
      (if (empty? (:path current))
        (:focus current)
        (recur (up current))))))

(defn set-value [zipper new-value]
  (when zipper
    (update zipper :focus assoc :value new-value)))

(defn set-left [zipper new-left]
  (when zipper
    (update zipper :focus assoc :left new-left)))

(defn set-right [zipper new-right]
  (when zipper
    (update zipper :focus assoc :right new-right)))
