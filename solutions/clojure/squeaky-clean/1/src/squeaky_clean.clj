(ns squeaky-clean
  (:require [clojure.string :as str]))

(defn clean
  [s]
  (let [underscored (str/replace s " " "_")
        controls-replaced (str/replace underscored #"[\u0000-\u001F\u007F-\u009F]" "CTRL")
        camel-cased (str/replace controls-replaced #"-([^-])"
                                 (fn [[_ character]] (str/upper-case character)))]
    (apply str
           (filter (fn [character]
                     (or (= character \_)
                         (and (Character/isLetter character)
                              (not (<= (int \α) (int character) (int \ω)))))
                   camel-cased))))
