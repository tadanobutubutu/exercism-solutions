(ns state-of-tic-tac-toe)

(def ^:private winning-lines
  [[0 1 2] [3 4 5] [6 7 8]
   [0 3 6] [1 4 7] [2 5 8]
   [0 4 8] [2 4 6]])

(defn- winning-lines-for [board player]
  (filter (fn [line]
            (every? (fn [position]
                      (= player (get-in board [(quot position 3) (mod position 3)])))
                    line))
          winning-lines))

(defn gamestate
  "Returns the gamestate of a tic-tac-toe board."
  [board]
  (let [board (mapv vec board)
        x-count (count (filter #{\X} (mapcat identity board)))
        o-count (count (filter #{\O} (mapcat identity board)))
        x-wins (seq (winning-lines-for board \X))
        o-wins (seq (winning-lines-for board \O))
        winner (cond x-wins \X o-wins \O)]
    (when (> x-count (inc o-count))
      (throw (IllegalArgumentException. "Wrong turn order: X went twice")))
    (when (> o-count x-count)
      (throw (IllegalArgumentException. "Wrong turn order: O started")))
    (when (and x-wins o-wins)
      (throw (IllegalArgumentException. "Impossible board: game should have ended after the game was won")))
    (when (and winner
               (let [last-player (if (> x-count o-count) \X \O)
                     valid-last-move? (some (fn [position]
                                              (and (= winner (get-in board [(quot position 3) (mod position 3)]))
                                                   (empty? (winning-lines-for
                                                            (assoc-in board [(quot position 3) (mod position 3)] \space)
                                                            winner))))
                                            (range 9))]
                 (or (not= winner last-player)
                     (not valid-last-move?))))
      (throw (IllegalArgumentException. "Impossible board: game should have ended after the game was won")))
    (cond
      winner :win
      (= (+ x-count o-count) 9) :draw
      :else :ongoing)))
