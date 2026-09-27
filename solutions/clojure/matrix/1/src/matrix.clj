(ns matrix
  (:require [clojure.string :as str]))

(defn- parse-matrix [matrix]
  (mapv (fn [row]
          (mapv #(Integer/parseInt %) (str/split (str/trim row) #"\s+")))
        (str/split-lines matrix)))

(defn get-row
  "Returns the i-th row of the matrix."
  [matrix i]
  (nth (parse-matrix matrix) (dec i)) )

(defn get-column
  "Returns the i-th column of the matrix."
  [matrix i]
  (mapv #(nth % (dec i)) (parse-matrix matrix)))
