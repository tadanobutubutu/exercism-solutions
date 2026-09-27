(ns proverb
  (:require [clojure.string :as str]))

(defn recite [words]
  (if (empty? words)
    ""
    (let [lines (map (fn [[item next-item]]
                       (str "For want of a " item " the " next-item " was lost."))
                     (partition 2 1 words))
          ending (str "And all for the want of a " (first words) ".")]
      (str/join "\n" (concat lines [ending])))))
