(ns pangram
  (:require [clojure.string :as str]))

(defn pangram?
  "Returns true if the given string is a pangram;
  otherwise, it returns false."
  [s]
  (= (set "abcdefghijklmnopqrstuvwxyz")
     (set (filter #(<= (int \a) (int %) (int \z))
                  (str/lower-case s))))
