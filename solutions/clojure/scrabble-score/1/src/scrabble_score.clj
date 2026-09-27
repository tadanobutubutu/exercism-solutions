(ns scrabble-score)

(def letter-scores
  (merge (zipmap "aeioulnrst" (repeat 1))
         (zipmap "dg" (repeat 2))
         (zipmap "bcmp" (repeat 3))
         (zipmap "fhvwy" (repeat 4))
         (zipmap "k" (repeat 5))
         (zipmap "jx" (repeat 8))
         (zipmap "qz" (repeat 10))))

(defn score-word
  "Returns the scrabble score of a word."
  [word]
  (reduce + 0 (map #(get letter-scores (Character/toLowerCase %) 0) word)))
