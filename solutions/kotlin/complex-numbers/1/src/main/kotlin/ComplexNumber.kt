import kotlin.math.cos
import kotlin.math.exp
import kotlin.math.hypot
import kotlin.math.sin

data class ComplexNumber(val real: Double = 0.0, val imag: Double = 0.0) {
    val abs: Double
        get() = hypot(real, imag)

    operator fun plus(other: ComplexNumber) = ComplexNumber(real + other.real, imag + other.imag)

    operator fun minus(other: ComplexNumber) = ComplexNumber(real - other.real, imag - other.imag)

    operator fun times(other: ComplexNumber) = ComplexNumber(
        real * other.real - imag * other.imag,
        imag * other.real + real * other.imag
    )

    operator fun div(other: ComplexNumber): ComplexNumber {
        val denominator = other.real * other.real + other.imag * other.imag
        return ComplexNumber(
            (real * other.real + imag * other.imag) / denominator,
            (imag * other.real - real * other.imag) / denominator
        )
    }

    fun conjugate() = ComplexNumber(real, -imag)
}

fun exponential(number: ComplexNumber): ComplexNumber {
    val magnitude = exp(number.real)
    return ComplexNumber(magnitude * cos(number.imag), magnitude * sin(number.imag))
}
