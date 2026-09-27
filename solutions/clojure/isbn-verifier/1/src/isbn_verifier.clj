(ns isbn-verifier
  (:require [clojure.string :as str]))

(defn isbn?
  "Returns true if the given isbn is valid;
  otherwise, it returns false."
  [isbn]
  (let [compact (str/replace isbn "-" "")]
    (boolean
     (and (re-matches #"[0-9]{9}[0-9X]" compact)
          (zero? (mod (reduce +
                             (map-indexed (fn [index digit]
                                            (* (- 10 index)
                                               (if (= digit \X)
                                                 10
                                                 (- (int digit) (int \0)))))
                                          compact))
                      11)))))
