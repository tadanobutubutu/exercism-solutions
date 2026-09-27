(ns diamond
  (:require [clojure.string :as str]))

(defn diamond
  "Returns a diamond shape pattern for the given letter."
  [letter]
  (let [last-index (- (int letter) (int \A))
        line (fn [index]
               (let [padding (apply str (repeat (- last-index index) \space))
                     character (char (+ (int \A) index))]
                 (if (zero? index)
                   (str padding character padding)
                   (str padding character
                        (apply str (repeat (dec (* 2 index)) \space))
                        character padding))))
        indexes (concat (range (inc last-index))
                        (range (dec last-index) -1 -1))]
    (str/join "\n" (map line indexes))))
