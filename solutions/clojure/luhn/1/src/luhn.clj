(ns luhn
  (:require [clojure.string :as str]))

(defn valid?
  "Returns true if the given string is a valid number;
  otherwise, it returns false."
  [s]
  (let [digits (str/replace s " " "")]
    (boolean
     (and (> (count digits) 1)
          (re-matches #"[0-9]+" digits)
          (zero? (mod
                  (reduce +
                          (map-indexed (fn [index character]
                                         (let [digit (- (int character) (int \0))
                                               doubled (if (odd? index) (* 2 digit) digit)]
                                           (if (> doubled 9) (- doubled 9) doubled)))
                                       (reverse digits)))
                  10)))))
