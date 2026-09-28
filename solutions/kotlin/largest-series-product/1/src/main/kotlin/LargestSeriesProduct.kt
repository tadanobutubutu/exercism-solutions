class Series(private val digits: String) {
    init {
        require(digits.all { it in '0'..'9' }) { "Series may contain only digits" }
    }

    fun getLargestProduct(span: Int): Long {
        require(span >= 0) { "Span must not be negative" }
        require(span <= digits.length) { "Span cannot exceed the series length" }
        if (span == 0) return 1L
        return (0..digits.length - span).maxOf { start ->
            (start until start + span).fold(1L) { product, index -> product * (digits[index] - '0') }
        }
    }
}
