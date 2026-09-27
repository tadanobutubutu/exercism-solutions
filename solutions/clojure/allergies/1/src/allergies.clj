(ns allergies)

(def allergen-scores
  [[:eggs 1] [:peanuts 2] [:shellfish 4] [:strawberries 8]
   [:tomatoes 16] [:chocolate 32] [:pollen 64] [:cats 128]])

(defn allergic-to?
  "Returns true if the score indicates an allergy to the allergen;
  otherwise, it returns false."
  [score allergen]
  (boolean (some (fn [[name value]]
                   (and (= name allergen) (pos? (bit-and score value))))
                 allergen-scores)))

(defn allergies
  "Returns all allergens associated with the score."
  [score]
  (into [] (keep (fn [[name value]]
                   (when (pos? (bit-and score value)) name))
                 allergen-scores)))
