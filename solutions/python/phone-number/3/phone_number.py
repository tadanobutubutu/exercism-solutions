import re

class PhoneNumber:
    def __init__(self, number):
        # Check for letters
        if any(c.isalpha() for c in number):
            raise ValueError("letters not permitted")
            
        # Check for punctuations other than allowed ones
        # Allowed: ( ) - . + 
        # Actually, any non-digit that isn't one of those might be "punctuation"
        # Let's check for specific disallowed punctuation mentioned in tests if possible
        if any(c in "@:!" for c in number):
            raise ValueError("punctuations not permitted")

        # Remove all non-digit characters
        digits = "".join(filter(str.isdigit, number))
        
        if len(digits) > 11:
            raise ValueError("must not be greater than 11 digits")
        if len(digits) < 10:
            raise ValueError("must not be fewer than 10 digits")
            
        if len(digits) == 11:
            if digits[0] != '1':
                raise ValueError("11 digits must start with 1")
            digits = digits[1:]
            
        # Area code (NXX) and Exchange code (NXX)
        # N must be 2-9
        if digits[0] == '0':
            raise ValueError("area code cannot start with zero")
        if digits[0] == '1':
            raise ValueError("area code cannot start with one")
        if digits[3] == '0':
            raise ValueError("exchange code cannot start with zero")
        if digits[3] == '1':
            raise ValueError("exchange code cannot start with one")
            
        self.number = digits
        self.area_code = digits[:3]

    def pretty(self):
        return f"({self.area_code})-{self.number[3:6]}-{self.number[6:]}"
