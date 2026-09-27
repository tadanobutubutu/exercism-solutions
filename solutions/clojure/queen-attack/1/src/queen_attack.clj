(ns queen-attack
  (:require [clojure.string :as str]))

(defn board-string [positions]
  (let [white (get positions :w)
        black (get positions :b)]
    (str (str/join "\n"
                   (for [row (range 8)]
                     (str/join " "
                               (for [column (range 8)]
                                 (cond
                                   (= [row column] white) "W"
                                   (= [row column] black) "B"
                                   :else "_")))))
         "\n")))

(defn can-attack [positions]
  (let [[white-row white-column] (:w positions)
        [black-row black-column] (:b positions)]
    (and (not= (:w positions) (:b positions))
         (or (= white-row black-row)
             (= white-column black-column)
             (= (Math/abs (- white-row black-row))
                (Math/abs (- white-column black-column))))))
