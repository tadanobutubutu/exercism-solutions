(ns secret-handshake)

(defn commands [number]
  (let [actions [[1 "wink"] [2 "double blink"] [4 "close your eyes"] [8 "jump"]]
        selected (keep (fn [[bit-value action]]
                         (when (pos? (bit-and number bit-value)) action))
                       actions)]
    (vec (if (pos? (bit-and number 16)) (reverse selected) selected))))
