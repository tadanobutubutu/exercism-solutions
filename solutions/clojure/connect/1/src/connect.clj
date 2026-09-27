(ns connect
  (:require [clojure.string :as str]))

(defn- neighbors [[row column]]
  [[row (dec column)] [row (inc column)]
   [(dec row) column] [(dec row) (inc column)]
   [(inc row) column] [(inc row) (dec column)]])

(defn- path-exists? [board player starts goal?]
  (let [starts (vec starts)]
    (loop [pending (into clojure.lang.PersistentQueue/EMPTY starts)
           visited (set starts)]
      (if (empty? pending)
        false
        (let [position (peek pending)
              pending (pop pending)]
          (if (goal? position)
            true
            (let [next-positions (filter (fn [[row column :as position]]
                                           (and (<= 0 row) (< row (count board))
                                                (<= 0 column) (< column (count (nth board row)))
                                                (= player (get-in board position))
                                                (not (contains? visited position))))
                                         (mapcat neighbors [position]))]
              (recur (into pending next-positions)
                     (into visited next-positions)))))))))

(defn connect-winner
  "Returns the winner of the given connect board."
  [board]
  (let [board (mapv (fn [row]
                      (let [trimmed (str/trim row)]
                        (if (empty? trimmed) [] (str/split trimmed #"\s+"))))
                    board)
        row-count (count board)
        column-count (if (zero? row-count) 0 (count (first board)))
        x-starts (for [row (range row-count)
                       :when (= "X" (get-in board [row 0]))]
                   [row 0])
        o-starts (for [column (range column-count)
                       :when (= "O" (get-in board [0 column]))]
                   [0 column])]
    (cond
      (path-exists? board "X" x-starts (fn [[_ column]] (= column (dec column-count)))) :X
      (path-exists? board "O" o-starts (fn [[row _]] (= row (dec row-count)))) :O
      :else :no-winner)))
