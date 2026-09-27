(ns atbash-cipher
  (:require [clojure.string :as str]))

(defn- transform-char [character]
  (let [character (Character/toLowerCase character)]
    (cond
      (<= (int \a) (int character) (int \z))
      (char (- (int \z) (- (int character) (int \a))))

      (<= (int \0) (int character) (int \9)) character
      :else nil)))

(defn encode
  "Encodes text using the Atbash cipher."
  [plaintext]
  (let [encoded (apply str (keep transform-char plaintext))]
    (str/join " " (map #(apply str %) (partition-all 5 encoded)))))

(defn decode
  "Decodes text using the Atbash cipher."
  [ciphertext]
  (apply str (keep transform-char ciphertext)))
