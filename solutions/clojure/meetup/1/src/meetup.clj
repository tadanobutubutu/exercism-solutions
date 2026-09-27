(ns meetup
  (:import [java.time LocalDate YearMonth]))

(def ^:private weekday-values
  {:monday 1 :tuesday 2 :wednesday 3 :thursday 4
   :friday 5 :saturday 6 :sunday 7})

(def ^:private week-index
  {:first 0 :second 1 :third 2 :fourth 3})

(defn meetup
  "Returns the date of the requested weekday in a given month."
  [month year weekday week]
  (let [target (get weekday-values weekday)
        last-day (.lengthOfMonth (YearMonth/of (int year) (int month)))
        matching-days (filter (fn [day]
                                (= target (.getValue (.getDayOfWeek
                                                     (LocalDate/of (int year) (int month) (int day))))))
                              (range 1 (inc last-day)))
        selected-day (case week
                       :teenth (first (filter #(<= 13 % 19) matching-days))
                       :last (last matching-days)
                       (nth matching-days (get week-index week)))]
    [year month selected-day]))
