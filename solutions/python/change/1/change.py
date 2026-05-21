def find_fewest_coins(coins, target):
    if target < 0:
        raise ValueError("target can't be negative")
    if target == 0:
        return []
    INF = float('inf')
    dp = [INF] * (target + 1)
    dp[0] = 0
    last = [None] * (target + 1)
    for coin in coins:
        for amount in range(coin, target + 1):
            if dp[amount - coin] + 1 < dp[amount]:
                dp[amount] = dp[amount - coin] + 1
                last[amount] = coin
    if dp[target] == INF:
        raise ValueError("can't make target with given coins")
    result = []
    while target > 0:
        result.append(last[target])
        target -= last[target]
    return sorted(result)
