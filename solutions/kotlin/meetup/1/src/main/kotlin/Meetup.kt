import java.time.DayOfWeek
import java.time.LocalDate

class Meetup(private val month: Int, private val year: Int) {

    fun day(dayOfWeek: DayOfWeek, schedule: MeetupSchedule): LocalDate {
        val firstOfMonth = LocalDate.of(year, month, 1)
        val matchingDays = (1..firstOfMonth.lengthOfMonth())
            .map { firstOfMonth.withDayOfMonth(it) }
            .filter { it.dayOfWeek == dayOfWeek }

        return when (schedule) {
            MeetupSchedule.FIRST -> matchingDays[0]
            MeetupSchedule.SECOND -> matchingDays[1]
            MeetupSchedule.THIRD -> matchingDays[2]
            MeetupSchedule.FOURTH -> matchingDays[3]
            MeetupSchedule.LAST -> matchingDays.last()
            MeetupSchedule.TEENTH -> matchingDays.first { it.dayOfMonth in 13..19 }
        }
    }
}
