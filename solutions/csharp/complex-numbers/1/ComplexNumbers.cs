public struct ComplexNumber
{
    private readonly double real;
    private readonly double imaginary;

    public ComplexNumber(double real, double imaginary)
    {
        this.real = real;
        this.imaginary = imaginary;
    }

    public double Real()
    {
        return real;
    }

    public double Imaginary()
    {
        return imaginary;
    }

    public ComplexNumber Mul(ComplexNumber other)
    {
        return new ComplexNumber(real * other.real - imaginary * other.imaginary, real * other.imaginary + imaginary * other.real);
    }

    public ComplexNumber Add(ComplexNumber other)
    {
        return new ComplexNumber(real + other.real, imaginary + other.imaginary);
    }

    public ComplexNumber Sub(ComplexNumber other)
    {
        return new ComplexNumber(real - other.real, imaginary - other.imaginary);
    }

    public ComplexNumber Div(ComplexNumber other)
    {
        var denominator = other.real * other.real + other.imaginary * other.imaginary;
        return new ComplexNumber((real * other.real + imaginary * other.imaginary) / denominator,
            (imaginary * other.real - real * other.imaginary) / denominator);
    }

    public double Abs()
    {
        return Math.Sqrt(real * real + imaginary * imaginary);
    }

    public ComplexNumber Conjugate()
    {
        return new ComplexNumber(real, -imaginary);
    }
    
    public ComplexNumber Exp()
    {
        var scale = Math.Exp(real);
        return new ComplexNumber(scale * Math.Cos(imaginary), scale * Math.Sin(imaginary));
    }

    public ComplexNumber Add(double other) => new(real + other, imaginary);

    public ComplexNumber Mul(double other) => new(real * other, imaginary * other);

    public ComplexNumber Div(double other) => new(real / other, imaginary / other);
}
