(ns pythagorean-triplet)

(defn find-pythagorean-triplets
  "Given an integer N, it returns all Pythagorean triplets
  for which a + b + c = N."
  [N]
  (letfn [(gcd [a b]
            (if (zero? b) a (recur b (mod a b))))]
    (let [maximum-m (long (Math/sqrt (/ (double N) 2.0)))]
      (vec
       (sort
        (for [m (range 2 (inc maximum-m))
              n (range 1 m)
              :let [factor (* 2 m (+ m n))]
              :when (and (zero? (mod N factor))
                         (= 1 (gcd m n))
                         (not= (mod m 2) (mod n 2)))
              :let [scale (quot N factor)
                    leg-a (* scale (- (* m m) (* n n)))
                    leg-b (* scale 2 m n)
                    hypotenuse (* scale (+ (* m m) (* n n)))]]
          (vec (sort [leg-a leg-b hypotenuse]))))))))
