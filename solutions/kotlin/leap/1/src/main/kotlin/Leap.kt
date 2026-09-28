data class Year(val number: Int) {
    val isLeap: Boolean = number % 400 == 0 || (number % 4 == 0 && number % 100 != 0)
}
