(ns nucleotide-count)

(def nucleotides [\A \C \G \T])

(defn- validate-strand [strand]
  (when-not (every? (set nucleotides) strand)
    (throw (IllegalArgumentException. "invalid nucleotide"))))

(defn count-of-nucleotide-in-strand [nucleotide strand]
  (validate-strand strand)
  (when-not (some #{nucleotide} nucleotides)
    (throw (IllegalArgumentException. "invalid nucleotide")))
  (count (filter #{nucleotide} strand)))

(defn nucleotide-counts [strand]
  (validate-strand strand)
  (into {} (map (fn [nucleotide]
                  [nucleotide (count (filter #{nucleotide} strand))])
                nucleotides)))
