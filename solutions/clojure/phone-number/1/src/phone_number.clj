(ns phone-number
  (:require [clojure.string :as str]))

(defn number
  [input]
  (let [invalid "0000000000"
        allowed? (re-matches #"\+?[0-9\s().-]+" input)
        digits (str/replace input #"\D" "")
        national (cond
                   (and (= 11 (count digits)) (= \1 (first digits))) (subs digits 1)
                   (= 10 (count digits)) digits
                   :else nil)]
    (if (and allowed?
             national
             (<= (int \2) (int (first national)) (int \9))
             (<= (int \2) (int (nth national 3)) (int \9)))
      national
      invalid)))
