(ns pov)

(defn- orient [target tree]
  (when (seq tree)
    (if (= target (first tree))
      tree
      (let [children (vec (rest tree))]
        (loop [index 0]
          (if (= index (count children))
            nil
            (let [pulled (orient target (nth children index))]
              (if pulled
                (let [siblings (vec (concat (subvec children 0 index)
                                            (subvec children (inc index))))
                      former-parent (into [(first tree)] siblings)]
                  (conj (vec pulled) former-parent))
                (recur (inc index))))))))))

(defn of [node tree]
  (orient node tree))

(defn- path-to [target tree]
  (when (seq tree)
    (if (= target (first tree))
      [(first tree)]
      (some (fn [child]
              (when-let [path (path-to target child)]
                (into [(first tree)] path)))
            (rest tree))))

(defn path-from-to [from to tree]
  (when-let [rooted (of from tree)]
    (path-to to rooted)))
