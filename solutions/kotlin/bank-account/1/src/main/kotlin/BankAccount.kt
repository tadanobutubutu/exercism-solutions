class BankAccount {
    private var currentBalance = 0L
    private var isClosed = false

    val balance: Long
        @Synchronized get() {
            checkOpen()
            return currentBalance
        }

    @Synchronized
    fun adjustBalance(amount: Long) {
        checkOpen()
        currentBalance += amount
    }

    @Synchronized
    fun close() {
        isClosed = true
        currentBalance = 0L
    }

    private fun checkOpen() {
        check(!isClosed) { "Account is closed" }
    }
}
