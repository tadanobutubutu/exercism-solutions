(ns anagram
  (:import [java.util Locale]))

(defn- normalized-word [word]
  (frequencies (.toLowerCase ^String word Locale/ROOT)))

(defn anagrams-for
  "Returns all words from candidates that are anagrams of the given word."
  [word candidates]
  (let [normalized (normalized-word word)
        lower-word (.toLowerCase ^String word Locale/ROOT)]
    (filterv (fn [candidate]
               (and (not= lower-word (.toLowerCase ^String candidate Locale/ROOT))
                    (= normalized (normalized-word candidate))))
             candidates)))
