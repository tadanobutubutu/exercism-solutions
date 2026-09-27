(ns two-fer)

(defn two-fer
  "Returns what you will say as you give away the extra cookie."
  ([] (two-fer "you"))
  ([name] (str "One for " name ", one for me.")))
