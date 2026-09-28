class PhoneNumber(input: String) {
    val number: String? = clean(input)

    private fun clean(input: String): String {
        require(input.all { it.isDigit() || it in " +().-" }) { "Invalid phone number characters" }
        var digits = input.filter(Char::isDigit)
        if (digits.length == 11) {
            require(digits[0] == '1') { "Invalid country code" }
            digits = digits.drop(1)
        }
        require(digits.length == 10) { "Phone number must contain 10 digits" }
        require(digits[0] in '2'..'9') { "Invalid area code" }
        require(digits[3] in '2'..'9') { "Invalid exchange code" }
        return digits
    }
}
