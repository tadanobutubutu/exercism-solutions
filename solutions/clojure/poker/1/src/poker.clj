(ns poker
  (:require [clojure.string :as str]))

(defn- card-rank [card]
  (let [rank (subs card 0 (dec (count card)))]
    (case rank
      "J" 11
      "Q" 12
      "K" 13
      "A" 14
      (Integer/parseInt rank))))

(defn- straight-high [ranks]
  (let [ordered (vec (sort ranks))]
    (when (= 5 (count (distinct ordered)))
      (cond
        (= ordered [2 3 4 5 14]) 5
        (= (- (last ordered) (first ordered)) 4) (last ordered)
        :else nil))))

(defn- hand-score [hand]
  (let [cards (str/split hand #" ")
        ranks (mapv card-rank cards)
        ordered-ranks (vec (sort > ranks))
        frequencies (frequencies ranks)
        pairs (vec (sort > (for [[rank amount] frequencies :when (= amount 2)] rank)))
        triples (vec (sort > (for [[rank amount] frequencies :when (= amount 3)] rank)))
        quad (first (for [[rank amount] frequencies :when (= amount 4)] rank))
        suits (mapv #(last %) cards)
        flush? (apply = suits)
        straight (straight-high ranks)
        kickers (fn [excluded]
                  (vec (sort > (remove excluded ranks))))]
    (cond
      (and flush? straight) [8 straight]
      quad [7 quad (first (kickers #{quad}))]
      (and (seq triples) (seq pairs)) [6 (first triples) (first pairs)]
      flush? (into [5] ordered-ranks)
      straight [4 straight]
      (seq triples) [3 (first triples) (kickers #{(first triples)})]
      (= 2 (count pairs)) [2 (first pairs) (second pairs) (first (kickers (set pairs)))]
      (seq pairs) [1 (first pairs) (kickers #{(first pairs)})]
      :else (into [0] ordered-ranks))))

(defn best-hands [hands]
  (let [best-score (last (sort (map hand-score hands)))]
    (filterv #(= best-score (hand-score %)) hands)))
