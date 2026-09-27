(ns rotational-cipher)

(defn rotate [text key]
  (apply str
         (map (fn [character]
                (cond
                  (<= (int \a) (int character) (int \z))
                  (char (+ (int \a) (mod (+ (- (int character) (int \a)) key) 26)))

                  (<= (int \A) (int character) (int \Z))
                  (char (+ (int \A) (mod (+ (- (int character) (int \A)) key) 26)))

                  :else character))
              text)))
