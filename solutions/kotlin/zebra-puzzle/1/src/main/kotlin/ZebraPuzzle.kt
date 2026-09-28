class ZebraPuzzle() {
    private data class Solution(val nationalities: IntArray, val drinks: IntArray, val pets: IntArray)
    private val solution by lazy(::solve)

    fun drinksWater(): String {
        val waterHouse = solution.drinks[WATER]
        return NATIONALITY_NAMES[solution.nationalities.indexOf(waterHouse)]
    }

    fun ownsZebra(): String {
        val zebraHouse = solution.pets[ZEBRA]
        return NATIONALITY_NAMES[solution.nationalities.indexOf(zebraHouse)]
    }

    private fun solve(): Solution {
        val permutations = permutations()
        for (nationalities in permutations) {
            if (nationalities[NORWEGIAN] != 0) continue
            for (colors in permutations) {
                if (nationalities[BRITISH] != colors[RED]) continue
                if (colors[GREEN] != colors[IVORY] + 1) continue
                if (kotlin.math.abs(nationalities[NORWEGIAN] - colors[BLUE]) != 1) continue
                for (drinks in permutations) {
                    if (drinks[COFFEE] != colors[GREEN]) continue
                    if (drinks[TEA] != nationalities[UKRAINIAN]) continue
                    if (drinks[MILK] != 2) continue
                    for (pets in permutations) {
                        if (pets[DOG] != nationalities[SPANISH]) continue
                        for (hobbies in permutations) {
                            if (hobbies[CHESS] != nationalities[JAPANESE]) continue
                            if (hobbies[PAINTING] != colors[YELLOW]) continue
                            if (hobbies[DANCING] != pets[SNAILS]) continue
                            if (hobbies[FOOTBALL] != drinks[ORANGE_JUICE]) continue
                            if (kotlin.math.abs(hobbies[READING] - pets[FOX]) != 1) continue
                            if (kotlin.math.abs(hobbies[PAINTING] - pets[HORSE]) != 1) continue
                            return Solution(nationalities, drinks, pets)
                        }
                    }
                }
            }
        }
        error("No solution found")
    }

    private fun permutations(): List<IntArray> {
        val result = mutableListOf<IntArray>()
        val values = IntArray(5)
        val used = BooleanArray(5)
        fun generate(index: Int) {
            if (index == values.size) {
                result.add(values.copyOf())
                return
            }
            for (value in 0 until values.size) {
                if (!used[value]) {
                    used[value] = true
                    values[index] = value
                    generate(index + 1)
                    used[value] = false
                }
            }
        }
        generate(0)
        return result
    }

    private companion object {
        const val BRITISH = 0
        const val SPANISH = 1
        const val UKRAINIAN = 2
        const val NORWEGIAN = 3
        const val JAPANESE = 4
        const val RED = 0
        const val GREEN = 1
        const val IVORY = 2
        const val YELLOW = 3
        const val BLUE = 4
        const val DOG = 0
        const val SNAILS = 1
        const val FOX = 2
        const val HORSE = 3
        const val ZEBRA = 4
        const val COFFEE = 0
        const val TEA = 1
        const val MILK = 2
        const val ORANGE_JUICE = 3
        const val WATER = 4
        const val DANCING = 0
        const val PAINTING = 1
        const val READING = 2
        const val FOOTBALL = 3
        const val CHESS = 4
        val NATIONALITY_NAMES = listOf("Englishman", "Spaniard", "Ukrainian", "Norwegian", "Japanese")
    }
}
