package change

import (
	"errors"
	"sort"
)

func Change(coins []int, target int) ([]int, error) {
	if target < 0 {
		return nil, errors.New("target cannot be negative")
	}
	if target == 0 {
		return []int{}, nil
	}
	validCoins := make([]int, 0, len(coins))
	for _, coin := range coins {
		if coin > 0 && coin <= target {
			validCoins = append(validCoins, coin)
		}
	}
	if len(validCoins) == 0 {
		return nil, errors.New("no change possible")
	}
	sort.Ints(validCoins)

	const unreachable = int(^uint(0) >> 1)
	minCoins := make([]int, target+1)
	lastCoin := make([]int, target+1)
	for amount := 1; amount <= target; amount++ {
		minCoins[amount] = unreachable
	}
	for amount := 1; amount <= target; amount++ {
		for _, coin := range validCoins {
			if coin > amount || minCoins[amount-coin] == unreachable {
				continue
			}
			candidate := minCoins[amount-coin] + 1
			if candidate < minCoins[amount] {
				minCoins[amount] = candidate
				lastCoin[amount] = coin
			}
		}
	}
	if minCoins[target] == unreachable {
		return nil, errors.New("no change possible")
	}
	result := make([]int, 0, minCoins[target])
	for amount := target; amount > 0; {
		coin := lastCoin[amount]
		if coin == 0 {
			return nil, errors.New("no change possible")
		}
		result = append(result, coin)
		amount -= coin
	}
	sort.Ints(result)
	return result, nil
}
