(ns isogram
  (:require [clojure.string :as str]))

(defn isogram?
  "Returns true if the given string is an isogram;
  otherwise, it returns false."
  [s]
  (let [letters (filter #(Character/isLetter %) (str/lower-case s))]
    (= (count letters) (count (set letters))))
