(ns elyses-destructured-enchantments)

(defn first-card
  "Returns the first card from deck."
  [deck]
  (let [[top-card & _] deck]
    top-card))

(defn second-card
  "Returns the second card from deck."
  [deck]
  (let [[_ second-card & _] deck]
    second-card))

(defn swap-top-two-cards
  "Returns the deck with first two items reversed."
  [deck]
  (let [[first-card second-card & remaining] deck]
    (vec (concat [second-card first-card] remaining))))

(defn discard-top-card
  "Returns a sequence containing the first card and
   a sequence of the remaining cards in the deck."
  [deck]
  (let [[top-card & remaining] deck]
    [top-card remaining]))

(def face-cards
  ["jack" "queen" "king"])

(defn insert-face-cards
  "Returns the deck with face cards between its head and tail."
  [deck]
  (let [[top-card & remaining] deck]
    (if (nil? top-card)
      face-cards
      (vec (concat [top-card] face-cards remaining)))))
