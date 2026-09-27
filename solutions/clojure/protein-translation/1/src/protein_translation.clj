(ns protein-translation)

(def codon-proteins
  {"AUG" "Methionine"
   "UUU" "Phenylalanine" "UUC" "Phenylalanine"
   "UUA" "Leucine" "UUG" "Leucine"
   "UCU" "Serine" "UCC" "Serine" "UCA" "Serine" "UCG" "Serine"
   "UAU" "Tyrosine" "UAC" "Tyrosine"
   "UGU" "Cysteine" "UGC" "Cysteine"
   "UGG" "Tryptophan"})

(def stop-codons #{"UAA" "UAG" "UGA"})

(defn translate-rna [rna]
  (loop [remaining rna
         proteins []]
    (cond
      (empty? remaining) proteins
      (< (count remaining) 3)
      (throw (IllegalArgumentException. "Invalid codon"))
      :else
      (let [codon (subs remaining 0 3)
            rest-rna (subs remaining 3)]
        (cond
          (contains? stop-codons codon) proteins
          (contains? codon-proteins codon)
          (recur rest-rna (conj proteins (get codon-proteins codon)))
          :else (throw (IllegalArgumentException. "Invalid codon"))))))
