(ns gigasecond
  (:import [java.time LocalDate]))

(defn from
  "Determines the date one gigasecond after the given date."
  [year month day]
  (let [start (.atStartOfDay (LocalDate/of year month day))
        later (.plusSeconds start 1000000000)]
    [(.getYear later) (.getMonthValue later) (.getDayOfMonth later)]))
