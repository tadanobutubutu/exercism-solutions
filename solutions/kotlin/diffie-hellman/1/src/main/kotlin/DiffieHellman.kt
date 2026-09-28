import java.math.BigInteger
import java.security.SecureRandom

object DiffieHellman {
    private val random = SecureRandom()

    fun privateKey(prime: BigInteger): BigInteger {
        require(prime > BigInteger.TWO) { "Prime must be greater than two" }
        while (true) {
            val candidate = BigInteger(prime.bitLength(), random)
            if (candidate > BigInteger.ONE && candidate < prime) return candidate
        }
    }

    fun publicKey(p: BigInteger, g: BigInteger, privKey: BigInteger): BigInteger {
        return g.modPow(privKey, p)
    }

    fun secret(prime: BigInteger, publicKey: BigInteger, privateKey: BigInteger): BigInteger {
        return publicKey.modPow(privateKey, prime)
    }
}
