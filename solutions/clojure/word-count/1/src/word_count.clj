(ns word-count
  (:require [clojure.string :as str]))

(defn word-count
  "Counts how many times each word occurs in the given string."
  [s]
  (frequencies (re-seq #"[a-z0-9]+(?:'[a-z0-9]+)*" (str/lower-case s)))
