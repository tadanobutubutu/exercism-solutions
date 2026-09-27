(ns kindergarten-garden
  (:require [clojure.string :as str]))

(def default-students
  ["Alice" "Bob" "Charlie" "David" "Eve" "Fred"
   "Ginny" "Harriet" "Ileana" "Joseph" "Kincaid" "Larry"])

(def plant-names {\V :violets, \R :radishes, \C :clover, \G :grass})

(defn garden
  ([diagram] (garden diagram default-students))
  ([diagram students]
   (let [[top bottom] (str/split-lines diagram)]
     (into {}
           (map-indexed
            (fn [index student]
              (let [start (* 2 index)
                    positions [(nth top start nil) (nth top (inc start) nil)
                                (nth bottom start nil) (nth bottom (inc start) nil)]]
                [(keyword (str/lower-case student))
                 (mapv plant-names positions)]))
            (sort students)))))
