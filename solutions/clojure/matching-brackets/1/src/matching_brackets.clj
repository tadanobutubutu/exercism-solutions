(ns matching-brackets)

(defn valid?
  "Returns true if the given string has properly matched brackets;
  otherwise, it returns false."
  [s]
  (loop [remaining (seq s)
         stack []]
    (if (empty? remaining)
      (empty? stack)
      (let [character (first remaining)]
        (case character
          \( (recur (rest remaining) (conj stack \)))
          \[ (recur (rest remaining) (conj stack \]))
          \{ (recur (rest remaining) (conj stack \}))
          \) (if (= \( (peek stack))
               (recur (rest remaining) (pop stack))
               false)
          \] (if (= \[ (peek stack))
               (recur (rest remaining) (pop stack))
               false)
          \} (if (= \{ (peek stack))
               (recur (rest remaining) (pop stack))
               false)
          (recur (rest remaining) stack))))))
