(ns simple-cipher)

(defn rand-key
  "Returns a random key."
  []
  (apply str (repeatedly 100 #(char (+ (int \a) (rand-int 26))))))

(defn encode
  "Encodes text using the specified key."
  [key plaintext]
  (apply str
         (map-indexed (fn [index character]
                        (let [key-character (nth key (mod index (count key)))
                              shift (- (int key-character) (int \a))]
                          (char (+ (int \a)
                                   (mod (+ (- (int character) (int \a)) shift) 26))))
                      plaintext)))

(defn decode
  "Decodes text using the specified key."
  [key ciphertext]
  (apply str
         (map-indexed (fn [index character]
                        (let [key-character (nth key (mod index (count key)))
                              shift (- (int key-character) (int \a))]
                          (char (+ (int \a)
                                   (mod (- (- (int character) (int \a)) shift) 26))))
                      ciphertext)))
