class Reactor<T>() {
    // Your compute cell's addCallback method must return an object
    // that implements the Subscription interface.
    interface Subscription {
        fun cancel()
    }

    open inner class Cell internal constructor(initialValue: T) {
        internal var storedValue: T = initialValue
        internal val dependents = linkedSetOf<ComputeCell>()
        open val value: T
            get() = storedValue
    }

    inner class InputCell(initialValue: T) : Cell(initialValue) {
        override var value: T
            get() = storedValue
            set(newValue) {
                setInputValue(this, newValue)
            }
    }

    inner class ComputeCell(
        vararg inputs: Cell,
        private val computation: (List<T>) -> T
    ) : Cell(computation(inputs.map { it.value })) {
        internal val inputs: List<Cell> = inputs.toList()
        private val callbacks = linkedMapOf<Long, (T) -> Unit>()

        init {
            for (input in inputs) input.dependents.add(this)
            computeCells.add(this)
        }

        fun addCallback(callback: (T) -> Unit): Subscription {
            val id = nextCallbackId++
            callbacks[id] = callback
            return object : Subscription {
                private var active = true
                override fun cancel() {
                    if (active) {
                        callbacks.remove(id)
                        active = false
                    }
                }
            }
        }

        internal fun recompute(): T = computation(inputs.map { it.value })

        internal fun notifyCallbacks() {
            val newValue = value
            callbacks.values.toList().forEach { it(newValue) }
        }
    }

    private val computeCells = mutableListOf<ComputeCell>()
    private var nextCallbackId = 0L
    private var isPropagating = false
    private val pendingInputs = linkedSetOf<InputCell>()

    private fun setInputValue(cell: InputCell, newValue: T) {
        if (cell.storedValue == newValue) return
        cell.storedValue = newValue
        pendingInputs.add(cell)
        if (!isPropagating) propagateChanges()
    }

    private fun propagateChanges() {
        isPropagating = true
        try {
            while (pendingInputs.isNotEmpty()) {
                val changedInputs = pendingInputs.toList()
                pendingInputs.clear()
                val affected = linkedSetOf<ComputeCell>()
                val queue = ArrayDeque<Cell>()
                changedInputs.forEach(queue::addLast)
                while (queue.isNotEmpty()) {
                    val cell = queue.removeFirst()
                    for (dependent in cell.dependents) {
                        if (affected.add(dependent)) queue.addLast(dependent)
                    }
                }

                val cellsWithChangedValues = mutableListOf<ComputeCell>()
                for (cell in computeCells) {
                    if (cell in affected) {
                        val newValue = cell.recompute()
                        if (newValue != cell.storedValue) {
                            cell.storedValue = newValue
                            cellsWithChangedValues.add(cell)
                        }
                    }
                }
                cellsWithChangedValues.forEach { it.notifyCallbacks() }
            }
        } finally {
            isPropagating = false
        }
    }
}
