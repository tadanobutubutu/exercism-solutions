(ns sublist)

(defn classify
  "Returns:
  :equal if coll1 equals coll2,
  :superlist if coll1 is a superlist of coll2,
  :sublist if coll1 is a sublist of coll2,

  If none of these conditions is true, it returns :unequal."
  [coll1 coll2]
  (let [first-list (vec coll1)
        second-list (vec coll2)
        contains-list? (fn [larger smaller]
                         (let [larger-size (count larger)
                               smaller-size (count smaller)]
                           (or (zero? smaller-size)
                               (and (<= smaller-size larger-size)
                                    (some #(= smaller (subvec larger % (+ % smaller-size)))
                                          (range (inc (- larger-size smaller-size))))))))]
    (cond
      (= first-list second-list) :equal
      (contains-list? first-list second-list) :superlist
      (contains-list? second-list first-list) :sublist
      :else :unequal)))
