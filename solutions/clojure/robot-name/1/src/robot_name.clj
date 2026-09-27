(ns robot-name)

(defonce ^:private names-in-use (atom #{}))

(defn- fresh-name []
  (loop []
    (let [name (str (char (+ (int \A) (rand-int 26)))
                    (char (+ (int \A) (rand-int 26)))
                    (format "%03d" (rand-int 1000)))
          current @names-in-use]
      (if (contains? current name)
        (recur)
        (if (compare-and-set! names-in-use current (conj current name))
          name
          (recur))))))

(defn robot []
  (atom (fresh-name)))

(defn robot-name [robot]
  @robot)

(defn reset-name [robot]
  (reset! robot (fresh-name)))
