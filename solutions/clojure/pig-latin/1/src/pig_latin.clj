(ns pig-latin
  (:require [clojure.string :as str]))

(defn- translate-word [word]
  (let [length (count word)
        first-vowel (first (filter #(let [character (nth word %)]
                                      (or (contains? #{\a \e \i \o \u} character)
                                          (and (pos? %) (= \y character))))
                                  (range length)))
        split-at (if (and first-vowel
                          (= \u (nth word first-vowel))
                          (> first-vowel 0)
                          (= \q (nth word (dec first-vowel))))
                   (inc first-vowel)
                   (or first-vowel 0))]
    (if (or (str/starts-with? word "xr")
            (str/starts-with? word "yt")
            (contains? #{\a \e \i \o \u} (first word)))
      (str word "ay")
      (str (subs word split-at) (subs word 0 split-at) "ay"))))

(defn translate
  "Translates phrase from English to Pig Latin."
  [phrase]
  (str/join " " (map translate-word (str/split phrase #"\s+"))))
