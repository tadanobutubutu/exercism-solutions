(ns clock)

(defn clock->string [clock]
  (let [minutes (mod clock 1440)]
    (format "%02d:%02d" (quot minutes 60) (mod minutes 60))))

(defn clock [hours minutes]
  (mod (+ (* hours 60) minutes) 1440))

(defn add-time [clock time]
  (mod (+ clock time) 1440))
