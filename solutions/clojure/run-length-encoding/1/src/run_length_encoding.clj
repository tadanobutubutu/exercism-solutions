(ns run-length-encoding)

(defn run-length-encode
  "Encodes a string with run-length encoding."
  [plaintext]
  (apply str
         (map (fn [run]
                (let [run-length (count run)]
                  (str (when (> run-length 1) run-length)
                       (first run))))
              (partition-by identity plaintext))))

(defn run-length-decode
  "Decodes a run-length-encoded string."
  [ciphertext]
  (apply str
         (map (fn [[_ count-text character]]
                (let [repetitions (if (empty? count-text)
                                    1
                                    (Integer/parseInt count-text))]
                  (apply str (repeat repetitions character))))
              (re-seq #"([0-9]*)([\s\S])" ciphertext))))
