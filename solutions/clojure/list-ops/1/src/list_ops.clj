(ns list-ops)

(defn append 
  "Given two vectors, it adds all the items in the second vector to the
  end of the first vector."
  [coll1 coll2]
  (loop [result coll1
         remaining coll2]
    (if (empty? remaining)
      result
      (recur (conj result (first remaining)) (rest remaining)))))

(defn concatenate 
  "Given a vector of vectors, it combines all the vectors into one flattened
  vector."
  [colls]
  (loop [result []
         remaining colls]
    (if (empty? remaining)
      result
      (recur (append result (first remaining)) (rest remaining)))))

(defn select-if
  "Given a predicate and a vector, it returns the vector of all items for
  which predicate(item) is true."
  [pred coll]
  (loop [result []
         remaining coll]
    (if (empty? remaining)
      result
        (let [item (first remaining)]
        (recur (if (pred item) (conj result item) result)
               (rest remaining))))))

(defn length 
  "Given a vector, it returns the number of items within it."
  [coll]
  (loop [size 0
         remaining coll]
    (if (empty? remaining)
      size
      (recur (inc size) (rest remaining)))))

(defn apply-to-each 
  "Given a function and a vector, it returns the vector of the results of
  applying function(item) on all items."
  [f coll]
  (loop [result []
         remaining coll]
    (if (empty? remaining)
      result
      (recur (conj result (f (first remaining))) (rest remaining)))))

(defn foldl 
  "Given a function, a vector, and initial accumulator, it folds (reduces)
  each item into the accumulator from the left."
  [f coll acc]
  (loop [result acc
         remaining coll]
    (if (empty? remaining)
      result
      (recur (f result (first remaining)) (rest remaining)))))

(defn foldr
  "Given a function, a vector, and an initial accumulator, it folds (reduces)
  each item into the accumulator from the right."
  [f coll acc]
  (if (empty? coll)
    acc
    (f (foldr f (rest coll) acc) (first coll))))

(defn reverse-order 
  "Given a vector, it returns a vector with all the original items, but in
  reverse order."
  [coll]
  (loop [result []
         remaining coll]
    (if (empty? remaining)
      result
      (recur (append [(first remaining)] result) (rest remaining)))))
