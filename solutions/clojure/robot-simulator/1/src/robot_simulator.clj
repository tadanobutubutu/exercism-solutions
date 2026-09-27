(ns robot-simulator)

(defn robot
  "Creates a robot at the given coordinates, facing the given direction."
  [coordinates direction]
  {:bearing direction :coordinates coordinates})

(defn simulate
  "Simulates the robot's movements based on the given instructions
  and updates its state."
  [instructions robot-state]
  (reduce (fn [{:keys [bearing coordinates] :as state} instruction]
            (case instruction
              \R (assoc state :bearing (get {:north :east :east :south
                                             :south :west :west :north} bearing))
              \L (assoc state :bearing (get {:north :west :west :south
                                             :south :east :east :north} bearing))
              \A (update state :coordinates
                         (fn [{:keys [x y]}]
                           (case bearing
                             :north {:x x :y (inc y)}
                             :south {:x x :y (dec y)}
                             :east {:x (inc x) :y y}
                             :west {:x (dec x) :y y})))
              state))
          robot-state instructions))
