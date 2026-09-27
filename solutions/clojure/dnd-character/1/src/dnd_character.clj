(ns dnd-character)

(defn score-modifier
  "Calculates the modifier of the given score."
  [score]
  (int (Math/floor (/ (- score 10) 2.0))))

(defn rand-ability
  "Generates a random ability."
  []
  (reduce + (rest (sort (repeatedly 4 #(inc (rand-int 6)))))))

(defn rand-character
  "Generates a random character."
  []
  (let [strength (rand-ability)
        dexterity (rand-ability)
        constitution (rand-ability)
        intelligence (rand-ability)
        wisdom (rand-ability)
        charisma (rand-ability)]
    {:strength strength
     :dexterity dexterity
     :constitution constitution
     :intelligence intelligence
     :wisdom wisdom
     :charisma charisma
     :hitpoints (+ 10 (score-modifier constitution))}))
