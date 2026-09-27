(ns bob
  (:require [clojure.string :as str]))

(defn response-for [s]
  (let [message (str/trim s)
        question? (str/ends-with? message "?")
        letters (re-seq #"[A-Za-z]" message)
        shouting? (and (seq letters) (= message (str/upper-case message)))]
    (cond
      (empty? message) "Fine. Be that way!"
      (and shouting? question?) "Calm down, I know what I'm doing!"
      shouting? "Whoa, chill out!"
      question? "Sure."
      :else "Whatever.")))
