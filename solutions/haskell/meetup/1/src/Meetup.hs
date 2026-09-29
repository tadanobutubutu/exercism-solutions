module Meetup (Weekday(..), Schedule(..), meetupDay) where

import Data.Time.Calendar (Day)
import qualified Data.Time.Calendar as Calendar

data Weekday = Monday
             | Tuesday
             | Wednesday
             | Thursday
             | Friday
             | Saturday
             | Sunday

data Schedule = First
              | Second
              | Third
              | Fourth
              | Last
              | Teenth

meetupDay :: Schedule -> Weekday -> Integer -> Int -> Day
meetupDay schedule weekday year month =
  case schedule of
    Teenth -> dateFor (head [day | day <- [13 .. 19], matches day])
    First -> dateFor (matchingDays !! 0)
    Second -> dateFor (matchingDays !! 1)
    Third -> dateFor (matchingDays !! 2)
    Fourth -> dateFor (matchingDays !! 3)
    Last -> dateFor (last matchingDays)
  where
    matchingDays = [day | day <- [1 .. 31], valid day, matches day]
    valid day = Calendar.fromGregorianValid year month day /= Nothing
    matches day =
      fmap Calendar.dayOfWeek (Calendar.fromGregorianValid year month day)
        == Just (calendarWeekday weekday)
    dateFor day = Calendar.fromGregorian year month day

calendarWeekday :: Weekday -> Calendar.DayOfWeek
calendarWeekday Monday = Calendar.Monday
calendarWeekday Tuesday = Calendar.Tuesday
calendarWeekday Wednesday = Calendar.Wednesday
calendarWeekday Thursday = Calendar.Thursday
calendarWeekday Friday = Calendar.Friday
calendarWeekday Saturday = Calendar.Saturday
calendarWeekday Sunday = Calendar.Sunday
