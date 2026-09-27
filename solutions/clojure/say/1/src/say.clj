(ns say
  (:require [clojure.string :as str]))

(def ^:private small-numbers
  ["zero" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine"
   "ten" "eleven" "twelve" "thirteen" "fourteen" "fifteen" "sixteen"
   "seventeen" "eighteen" "nineteen"])

(def ^:private tens-names
  [nil nil "twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "ninety"])

(defn- say-under-thousand [value]
  (let [hundreds (quot value 100)
        remainder (mod value 100)
        hundreds-words (if (pos? hundreds)
                         [(str (nth small-numbers hundreds) " hundred")]
                         [])
        remainder-words (cond
                          (zero? remainder) []
                          (< remainder 20) [(nth small-numbers remainder)]
                          :else (let [tens (nth tens-names (quot remainder 10))
                                      ones (mod remainder 10)]
                                  [(if (zero? ones)
                                     tens
                                     (str tens "-" (nth small-numbers ones)))])]
    (str/join " " (concat hundreds-words remainder-words))))

(defn number [num]
  (when (or (neg? num) (> num 999999999999))
    (throw (IllegalArgumentException. "number out of range")))
  (if (zero? num)
    "zero"
    (str/join " "
              (for [[divisor scale] [[1000000000 "billion"]
                                     [1000000 "million"]
                                     [1000 "thousand"]
                                     [1 ""]]
                    :let [group (mod (quot num divisor) 1000)]
                    :when (pos? group)]
                (str (say-under-thousand group)
                     (when-not (empty? scale) (str " " scale)))))))
