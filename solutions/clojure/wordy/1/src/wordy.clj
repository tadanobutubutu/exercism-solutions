(ns wordy
  (:require [clojure.string :as str]))

(defn- syntax-error []
  (throw (IllegalArgumentException. "syntax error")))

(defn- unknown-operation []
  (throw (IllegalArgumentException. "unknown operation")))

(defn- number-token? [token]
  (boolean (re-matches #"-?[0-9]+" token)))

(defn- parse-number [token]
  (bigint (java.math.BigInteger. token)))

(defn- parse-operation [tokens position]
  (when (>= position (count tokens))
    (syntax-error))
  (let [token (nth tokens position)]
    (case token
      "plus" [:+ (inc position)]
      "minus" [:- (inc position)]
      "multiplied" (if (and (< (inc position) (count tokens))
                            (= "by" (nth tokens (inc position))))
                     [:* (+ position 2)]
                     (syntax-error))
      "divided" (if (and (< (inc position) (count tokens))
                         (= "by" (nth tokens (inc position))))
                  [:/ (+ position 2)]
                  (syntax-error))
      (if (number-token? token)
        (syntax-error)
        (unknown-operation)))))

(defn evaluate
  "Evaluates a simple math question."
  [question]
  (when-not (and (str/starts-with? question "What is ")
                 (str/ends-with? question "?")
                 (> (count question) 9))
    (syntax-error))
  (let [body (subs question 8 (dec (count question)))
        tokens (vec (str/split (str/trim body) #"\s+"))]
    (when (or (empty? tokens) (not (number-token? (first tokens))))
      (syntax-error))
    (loop [answer (parse-number (first tokens))
           position 1]
      (if (= position (count tokens))
        answer
        (let [[operation operand-position] (parse-operation tokens position)]
          (when (or (>= operand-position (count tokens))
                    (not (number-token? (nth tokens operand-position))))
            (syntax-error))
          (let [operand (parse-number (nth tokens operand-position))]
            (recur (case operation
                     :+ (+ answer operand)
                     :- (- answer operand)
                     :* (* answer operand)
                     :/ (quot answer operand))
                   (inc operand-position)))))))
