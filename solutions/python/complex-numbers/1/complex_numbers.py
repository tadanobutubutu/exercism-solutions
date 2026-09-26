import math


class ComplexNumber:
    def __init__(self, real, imaginary):
        self.real = real
        self.imaginary = imaginary

    def __eq__(self, other):
        if not isinstance(other, ComplexNumber):
            if isinstance(other, (int, float)):
                other = ComplexNumber(other, 0)
            else:
                return NotImplemented
        return math.isclose(self.real, other.real, abs_tol=1e-9) and math.isclose(
            self.imaginary, other.imaginary, abs_tol=1e-9
        )

    def __add__(self, other):
        if isinstance(other, (int, float)):
            other = ComplexNumber(other, 0)
        if not isinstance(other, ComplexNumber):
            return NotImplemented
        return ComplexNumber(self.real + other.real, self.imaginary + other.imaginary)

    __radd__ = __add__

    def __mul__(self, other):
        if isinstance(other, (int, float)):
            other = ComplexNumber(other, 0)
        if not isinstance(other, ComplexNumber):
            return NotImplemented
        return ComplexNumber(
            self.real * other.real - self.imaginary * other.imaginary,
            self.imaginary * other.real + self.real * other.imaginary,
        )

    __rmul__ = __mul__

    def __sub__(self, other):
        if isinstance(other, (int, float)):
            other = ComplexNumber(other, 0)
        if not isinstance(other, ComplexNumber):
            return NotImplemented
        return ComplexNumber(self.real - other.real, self.imaginary - other.imaginary)

    def __rsub__(self, other):
        if isinstance(other, (int, float)):
            other = ComplexNumber(other, 0)
        if not isinstance(other, ComplexNumber):
            return NotImplemented
        return other - self

    def __truediv__(self, other):
        if isinstance(other, (int, float)):
            other = ComplexNumber(other, 0)
        if not isinstance(other, ComplexNumber):
            return NotImplemented
        denominator = other.real**2 + other.imaginary**2
        return ComplexNumber(
            (self.real * other.real + self.imaginary * other.imaginary) / denominator,
            (self.imaginary * other.real - self.real * other.imaginary) / denominator,
        )

    def __rtruediv__(self, other):
        if isinstance(other, (int, float)):
            other = ComplexNumber(other, 0)
        if not isinstance(other, ComplexNumber):
            return NotImplemented
        return other / self

    def __abs__(self):
        return math.hypot(self.real, self.imaginary)

    def conjugate(self):
        return ComplexNumber(self.real, -self.imaginary)

    def exp(self):
        magnitude = math.exp(self.real)
        return ComplexNumber(
            magnitude * math.cos(self.imaginary),
            magnitude * math.sin(self.imaginary),
        )
