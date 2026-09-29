#include "high_scores.h"

int32_t latest(const int32_t *scores, size_t scores_len)
{
    return scores_len == 0 ? 0 : scores[scores_len - 1];
}

int32_t personal_best(const int32_t *scores, size_t scores_len)
{
    if (scores_len == 0) {
        return 0;
    }

    int32_t best = scores[0];
    for (size_t i = 1; i < scores_len; ++i) {
        if (scores[i] > best) {
            best = scores[i];
        }
    }
    return best;
}

size_t personal_top_three(const int32_t *scores, size_t scores_len,
                          int32_t *output)
{
    int32_t top[3];
    size_t count = 0;

    for (size_t i = 0; i < scores_len; ++i) {
        int32_t score = scores[i];
        if (count == 3 && score <= top[2]) {
            continue;
        }

        size_t position = count < 3 ? count : 2;
        if (count < 3) {
            ++count;
        }
        while (position > 0 && score > top[position - 1]) {
            top[position] = top[position - 1];
            --position;
        }
        top[position] = score;
    }

    for (size_t i = 0; i < count; ++i) {
        output[i] = top[i];
    }
    return count;
}
