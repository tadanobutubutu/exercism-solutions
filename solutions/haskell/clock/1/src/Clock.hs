module Clock (addDelta, fromHourMin, toString) where

newtype Clock = Clock Int
  deriving Eq

fromHourMin :: Int -> Int -> Clock
fromHourMin hour minute = Clock ((hour * 60 + minute) `mod` minutesPerDay)

toString :: Clock -> String
toString (Clock totalMinutes) = twoDigits hours ++ ":" ++ twoDigits minutes
  where
    (hours, minutes) = totalMinutes `divMod` 60
    twoDigits n = if n < 10 then '0' : show n else show n

addDelta :: Int -> Int -> Clock -> Clock
addDelta hours minutes (Clock totalMinutes) =
  Clock ((totalMinutes + hours * 60 + minutes) `mod` minutesPerDay)

minutesPerDay :: Int
minutesPerDay = 24 * 60
