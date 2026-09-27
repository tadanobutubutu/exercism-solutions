(ns acronym
  (:require [clojure.string :as str]))

(defn acronym
  "Converts phrase to its acronym."
  [phrase]
  (let [words (re-seq #"[A-Za-z]+" (str/replace phrase #"[^A-Za-z\s-]" ""))]
    (apply str (map #(str/upper-case (subs % 0 1)) words)))
