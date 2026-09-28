object PigLatin {

    fun translate(phrase: String): String {
        return Regex("\\S+").replace(phrase) { match ->
            val word = match.value
            if (word.startsWith("xr") || word.startsWith("yt") || word.firstOrNull()?.let { it in "aeiou" } == true) {
                "${word}ay"
            } else {
                var splitAt = 0
                while (splitAt < word.length) {
                    if (word[splitAt] == 'q' && splitAt + 1 < word.length && word[splitAt + 1] == 'u') {
                        splitAt += 2
                    } else if (word[splitAt] in "aeiou" || (word[splitAt] == 'y' && splitAt > 0)) {
                        break
                    } else {
                        splitAt++
                    }
                }
                word.substring(splitAt) + word.substring(0, splitAt) + "ay"
            }
        }
    }
}
