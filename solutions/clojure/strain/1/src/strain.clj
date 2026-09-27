(ns strain)

(defn retain
  "Keeps the items in coll for which (pred item) returns true."
  [pred coll]
  (reduce (fn [result item]
            (if (pred item) (conj result item) result))
          [] coll))

(defn discard
  "Removes the items in coll for which (pred item) returns true."
  [pred coll]
  (reduce (fn [result item]
            (if (pred item) result (conj result item)))
          [] coll))
