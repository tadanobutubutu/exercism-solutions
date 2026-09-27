(ns beer-song
  (:require [clojure.string :as str]))

(defn verse
  "Returns the nth verse of the song."
  [num]
  (if (zero? num)
    (str "No more bottles of beer on the wall, no more bottles of beer.\n"
         "Go to the store and buy some more, 99 bottles of beer on the wall.")
    (let [current (str num " bottle" (when (not= num 1) "s"))
          next-num (dec num)
          next-bottles (if (zero? next-num)
                         "no more bottles"
                         (str next-num " bottle" (when (not= next-num 1) "s")))
          action (if (= num 1)
                   "Take it down and pass it around"
                   "Take one down and pass it around")]
      (str current " of beer on the wall, " current " of beer.\n"
           action ", " next-bottles " of beer on the wall."))))

(defn sing
  "Given a start and an optional end, returns all verses in this interval. If
  end is not given, the whole song from start is sung."
  ([start] (sing start 0))
  ([start end]
   (str/join "\n\n" (map verse (range start (dec end) -1)))))
