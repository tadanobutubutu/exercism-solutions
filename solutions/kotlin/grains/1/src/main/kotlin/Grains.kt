import java.math.BigInteger

object Board {

    fun getGrainCountForSquare(number: Int): BigInteger {
        require(number in 1..64) { "Square must be between 1 and 64" }
        return BigInteger.ONE.shiftLeft(number - 1)
    }

    fun getTotalGrainCount(): BigInteger = BigInteger.ONE.shiftLeft(64).subtract(BigInteger.ONE)
}
