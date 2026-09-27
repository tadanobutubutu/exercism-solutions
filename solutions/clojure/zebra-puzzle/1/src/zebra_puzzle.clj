(ns zebra-puzzle)

(defn- permutations [values]
  (if (empty? values)
    [[]]
    (for [value values
          suffix (permutations (remove #{value} values))]
      (into [value] suffix))))

(defn- position [values value]
  (first (keep-indexed (fn [index item]
                         (when (= item value) index))
                       values)))

(defn- adjacent? [left right]
  (= 1 (Math/abs (int (- left right)))))

(defn- find-solution []
  (let [color-permutations (vec (permutations [:red :green :ivory :yellow :blue]))
        nation-permutations (vec (permutations [:englishman :spaniard :ukrainian :norwegian :japanese]))
        drink-permutations (vec (permutations [:coffee :tea :milk :orange-juice :water]))
        hobby-permutations (vec (permutations [:dancing :painting :reading :football :chess]))
        pet-permutations (vec (permutations [:dog :snails :fox :horse :zebra]))]
    (first
     (for [colors color-permutations
           :let [red (position colors :red)
                 green (position colors :green)
                 ivory (position colors :ivory)
                 yellow (position colors :yellow)
                 blue (position colors :blue)]
           :when (= green (inc ivory))
           nations nation-permutations
           :let [englishman (position nations :englishman)
                 spaniard (position nations :spaniard)
                 ukrainian (position nations :ukrainian)
                 norwegian (position nations :norwegian)
                 japanese (position nations :japanese)]
           :when (and (= norwegian 0)
                      (= englishman red)
                      (= blue 1))
           drinks drink-permutations
           :let [coffee (position drinks :coffee)
                 tea (position drinks :tea)
                 milk (position drinks :milk)
                 orange-juice (position drinks :orange-juice)]
           :when (and (= milk 2)
                      (= coffee green)
                      (= tea ukrainian))
           hobbies hobby-permutations
           :let [dancing (position hobbies :dancing)
                 painting (position hobbies :painting)
                 reading (position hobbies :reading)
                 football (position hobbies :football)
                 chess (position hobbies :chess)]
           :when (and (= yellow painting)
                      (= japanese chess)
                      (= football orange-juice))
           pets pet-permutations
           :let [dog (position pets :dog)
                 snails (position pets :snails)
                 fox (position pets :fox)
                 horse (position pets :horse)
                 zebra (position pets :zebra)]
           :when (and (= spaniard dog)
                      (= snails dancing)
                      (adjacent? reading fox)
                      (adjacent? painting horse))]
       {:nations nations :drinks drinks :pets pets}))))

(def ^:private solution (find-solution))

(defn drinks-water
  "Returns who drinks water."
  []
  (nth (:nations solution) (position (:drinks solution) :water)))

(defn owns-zebra
  "Returns who owns the zebra."
  []
  (nth (:nations solution) (position (:pets solution) :zebra)))
