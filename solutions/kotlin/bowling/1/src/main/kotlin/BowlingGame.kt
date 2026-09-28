class BowlingGame {
    private val rolls = mutableListOf<Int>()

    fun roll(pins: Int) {
        check(!isComplete()) { "Game is already complete" }
        check(pins in 0..10) { "A roll must knock down between 0 and 10 pins" }

        val tenthFrameStart = firstNineFramesEnd()
        if (tenthFrameStart == null) {
            var index = 0
            repeat(9) {
                if (index >= rolls.size) return@repeat
                if (rolls[index] == 10) {
                    index++
                } else if (index + 1 >= rolls.size) {
                    check(rolls[index] + pins <= 10) { "A frame cannot knock down more than 10 pins" }
                    rolls.add(pins)
                    return
                } else {
                    index += 2
                }
            }
            rolls.add(pins)
            return
        }

        val tenthRolls = rolls.drop(tenthFrameStart)
        when (tenthRolls.size) {
            0 -> Unit
            1 -> if (tenthRolls[0] < 10) {
                check(tenthRolls[0] + pins <= 10) { "A frame cannot knock down more than 10 pins" }
            }
            2 -> if (tenthRolls[0] == 10 && tenthRolls[1] < 10) {
                check(tenthRolls[1] + pins <= 10) { "A bonus frame cannot knock down more than 10 pins" }
            }
        }
        rolls.add(pins)
    }

    fun score(): Int {
        check(isComplete()) { "Game is incomplete" }
        var total = 0
        var index = 0
        repeat(10) {
            if (rolls[index] == 10) {
                total += 10 + rolls[index + 1] + rolls[index + 2]
                index++
            } else {
                val frameScore = rolls[index] + rolls[index + 1]
                total += if (frameScore == 10) frameScore + rolls[index + 2] else frameScore
                index += 2
            }
        }
        return total
    }

    private fun firstNineFramesEnd(): Int? {
        var index = 0
        repeat(9) {
            if (index >= rolls.size) return null
            if (rolls[index] == 10) {
                index++
            } else {
                if (index + 1 >= rolls.size) return null
                index += 2
            }
        }
        return index
    }

    private fun isComplete(): Boolean {
        val start = firstNineFramesEnd() ?: return false
        val tenth = rolls.drop(start)
        if (tenth.isEmpty()) return false
        return if (tenth[0] == 10) {
            tenth.size == 3
        } else if (tenth.size < 2) {
            false
        } else {
            tenth[0] + tenth[1] < 10 || tenth.size == 3
        }
    }
}
