(ns food-chain
  (:require [clojure.string :as str]))

(def animals ["fly" "spider" "bird" "cat" "dog" "goat" "cow" "horse"])
(def remarks [nil
              "It wriggled and jiggled and tickled inside her."
              "How absurd to swallow a bird!"
              "Imagine that, to swallow a cat!"
              "What a hog, to swallow a dog!"
              "Just opened her throat and swallowed a goat!"
              "I don't know how she swallowed a cow!"
              "She's dead, of course!"])

(defn- verse-lines [index]
  (let [animal (nth animals index)
        introduction (str "I know an old lady who swallowed a " animal ".")
        remark (nth remarks index)
        catches (when (< index 7)
                  (for [current (range index 0 -1)
                        :let [prey (nth animals (dec current))
                              detail (when (= prey "spider")
                                       " that wriggled and jiggled and tickled inside her")]]
                    (str "She swallowed the " (nth animals current)
                         " to catch the " prey detail ".")))
        ending (when (< index 7)
                 ["I don't know why she swallowed the fly. Perhaps she'll die."])]
    (vec (concat [introduction] (when remark [remark]) catches ending))))

(defn recite
  "Returns the lyrics of the song: 'I Know an Old Lady Who Swallowed a Fly.'"
  [start-verse end-verse]
  (str/join "\n\n"
            (map #(str/join "\n" (verse-lines %))
                            (range (dec start-verse) end-verse))))
