using System.Numerics;
using System.Security.Cryptography;

public static class DiffieHellman
{
    public static BigInteger PrivateKey(BigInteger primeP) 
    {
        if (primeP <= 2)
        {
            throw new ArgumentOutOfRangeException(nameof(primeP));
        }

        BigInteger range = primeP - 2;
        int byteCount = range.ToByteArray(isUnsigned: true, isBigEndian: true).Length;
        byte[] bytes = new byte[byteCount];
        BigInteger candidate;
        do
        {
            RandomNumberGenerator.Fill(bytes);
            candidate = new BigInteger(bytes, isUnsigned: true, isBigEndian: true);
        } while (candidate >= range);

        return candidate + 2;
    }

    public static BigInteger PublicKey(BigInteger primeP, BigInteger primeG, BigInteger privateKey) 
    {
        return BigInteger.ModPow(primeG, privateKey, primeP);
    }

    public static BigInteger Secret(BigInteger primeP, BigInteger publicKey, BigInteger privateKey) 
    {
        return BigInteger.ModPow(publicKey, privateKey, primeP);
    }
}
