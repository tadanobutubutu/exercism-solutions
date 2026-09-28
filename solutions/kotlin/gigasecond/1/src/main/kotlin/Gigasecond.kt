import java.time.LocalDate
import java.time.LocalDateTime

class Gigasecond(private val moment: LocalDateTime) {
    constructor(date: LocalDate) : this(date.atStartOfDay())

    val date: LocalDateTime = moment.plusSeconds(1_000_000_000L)
}
