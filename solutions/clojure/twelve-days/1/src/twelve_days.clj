(ns twelve-days
  (:require [clojure.string :as str]))

(def ^:private ordinals
  ["first" "second" "third" "fourth" "fifth" "sixth"
   "seventh" "eighth" "ninth" "tenth" "eleventh" "twelfth"])

(def ^:private gifts
  ["a Partridge in a Pear Tree"
   "two Turtle Doves"
   "three French Hens"
   "four Calling Birds"
   "five Gold Rings"
   "six Geese-a-Laying"
   "seven Swans-a-Swimming"
   "eight Maids-a-Milking"
   "nine Ladies Dancing"
   "ten Lords-a-Leaping"
   "eleven Pipers Piping"
   "twelve Drummers Drumming"])

(defn- verse [day]
  (let [day-gifts (reverse (take day gifts))
        gift-list (if (= day 1)
                    (first day-gifts)
                    (str (str/join ", " (butlast day-gifts))
                         ", and " (last day-gifts)))]
    (str "On the " (nth ordinals (dec day))
         " day of Christmas my true love gave to me: " gift-list ".")))

(defn recite
  "Returns the lyrics of the song: 'The Twelve Days of Christmas.'"
  [start-verse end-verse]
  (str/join "\n" (map verse (range start-verse (inc end-verse)))))
