enum class Classification {
    DEFICIENT, PERFECT, ABUNDANT
}

fun classify(naturalNumber: Int): Classification {
    require(naturalNumber > 0) { "Number must be natural" }
    val number = naturalNumber.toLong()
    var aliquotSum = if (number == 1L) 0L else 1L
    var divisor = 2L
    while (divisor * divisor <= number) {
        if (number % divisor == 0L) {
            aliquotSum += divisor
            val paired = number / divisor
            if (paired != divisor) aliquotSum += paired
        }
        divisor++
    }
    return when {
        aliquotSum == number -> Classification.PERFECT
        aliquotSum > number -> Classification.ABUNDANT
        else -> Classification.DEFICIENT
    }
}
