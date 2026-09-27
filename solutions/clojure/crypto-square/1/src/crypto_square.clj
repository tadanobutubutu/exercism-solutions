(ns crypto-square
  (:require [clojure.string :as str]))

(defn normalize-plaintext [plaintext]
  (str/replace (str/lower-case plaintext) #"[^a-z0-9]" ""))

(defn square-size [plaintext]
  (let [length (count (normalize-plaintext plaintext))]
    (loop [size 0]
      (if (>= (* size size) length)
        size
        (recur (inc size))))))

(defn plaintext-segments [plaintext]
  (let [normalized (normalize-plaintext plaintext)
        size (square-size normalized)]
    (if (zero? size)
      []
      (mapv #(apply str %) (partition-all size normalized)))))

(defn ciphertext [plaintext]
  (let [normalized (normalize-plaintext plaintext)
        segments (plaintext-segments normalized)
        columns (square-size normalized)]
    (apply str
           (for [column (range columns)
                 segment segments
                 :when (< column (count segment))]
             (nth segment column)))))

(defn normalize-ciphertext [plaintext]
  (let [normalized (normalize-plaintext plaintext)
        length (count normalized)
        columns (square-size normalized)]
    (if (zero? length)
      ""
      (let [rows (long (Math/ceil (/ (double length) columns)))
            chunks (partition-all rows (ciphertext normalized))]
        (str/join " "
                  (map (fn [chunk]
                         (let [text (apply str chunk)]
                           (str text (apply str (repeat (- rows (count text)) \space)))))
                       chunks))))))
