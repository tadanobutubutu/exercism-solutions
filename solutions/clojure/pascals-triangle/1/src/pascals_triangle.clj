(ns pascals-triangle)

(defn- next-row [previous]
  (mapv +' (cons 0 previous) (concat previous [0])))

(def triangle
  (iterate next-row [1]))

(defn row [n]
  (nth triangle (dec n)))
