(ns transpose
  (:require [clojure.string :as str]))

(defn transpose
  "Returns the transposed version of the given string."
  [s]
  (let [rows (str/split s #"\n" -1)
        width (reduce max 0 (map count rows))]
    (str/join
     "\n"
     (map (fn [column]
            (let [characters (mapv #(when (< column (count %)) (nth % column)) rows)
                  last-present (last (keep-indexed (fn [index character]
                                                     (when (some? character) index))
                                                   characters))]
              (apply str (map #(or % \space) (take (inc last-present) characters)))))
          (range width))))
