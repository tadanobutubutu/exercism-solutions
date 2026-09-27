(ns grade-school)

(defn grade [school grade]
  (get school grade []))

(defn add [school name grade]
  (when (some #{name} (mapcat val school))
    (throw (IllegalArgumentException. "student already exists in the roster")))
  (update school grade (fnil conj []) name))

(defn sorted [school]
  (into (sorted-map)
        (map (fn [[grade students]] [grade (vec (sort students))]) school)))
