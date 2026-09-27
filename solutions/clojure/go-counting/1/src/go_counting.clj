(ns go-counting)

(def ^:private directions
  [[0 1] [0 -1] [1 0] [-1 0]])

(defn- grid->points [grid]
  (let [row-count (count grid)
        column-count (if (zero? row-count) 0 (count (first grid)))]
    (into {}
          (for [row (range row-count)
                column (range column-count)]
            [[column row]
             (case (nth (nth grid row) column)
               \B :black
               \W :white
               \space :free)]))))

(defn- neighbors [points [x y]]
  (for [[dx dy] directions
        :let [position [(+ x dx) (+ y dy)]]
        :when (contains? points position)]
    position))

(defn- free-region [points start]
  (loop [pending [start]
         region #{}]
    (if (empty? pending)
      region
      (let [position (first pending)
            remaining (rest pending)]
        (if (or (contains? region position)
                (not= :free (get points position)))
          (recur remaining region)
          (recur (concat remaining
                         (remove region (neighbors points position)))
                 (conj region position)))))))

(defn- region-owner [points region]
  (let [owners (into #{}
                     (for [position region
                           neighbor (neighbors points position)
                           :let [owner (get points neighbor)]
                           :when (#{:black :white} owner)]
                       owner))]
    (cond
      (= owners #{:black}) :black
      (= owners #{:white}) :white
      :else nil)))

(defn territory [grid [x y]]
  (let [points (grid->points grid)
        position [x y]]
    (when-not (contains? points position)
      (throw (Throwable. "Invalid coordinate")))
    (let [region (if (= :free (get points position))
                   (free-region points position)
                   #{})]
      {:stones region
       :owner (region-owner points region)})))

(defn territories [grid]
  (let [points (grid->points grid)
        free-points (for [[position color] points :when (= color :free)] position)]
    (loop [remaining (seq free-points)
           visited #{}
           result {:black-territory #{}
                   :white-territory #{}
                   :null-territory #{}}]
      (if (empty? remaining)
        result
        (let [position (first remaining)]
          (if (contains? visited position)
            (recur (rest remaining) visited result)
            (let [region (free-region points position)
                  owner (region-owner points region)
                  key (case owner
                        :black :black-territory
                        :white :white-territory
                        :null-territory)]
              (recur (rest remaining)
                     (into visited region)
                     (update result key into region)))))))))
