class Change
  class ImpossibleCombinationError < StandardError; end
  class NegativeTargetError < StandardError; end

  def self.generate(coins, target)
    raise NegativeTargetError, "negative target" if target < 0
    return [] if target == 0
    raise ImpossibleCombinationError, "impossible" if coins.empty? || target < coins.min

    # DP approach: find coins to minimize count
    dp = Array.new(target + 1, nil)
    dp[0] = []

    for i in 1..target
      for coin in coins
        if i >= coin && dp[i - coin] != nil
          if dp[i].nil? || dp[i - coin].size + 1 < dp[i].size
            dp[i] = dp[i - coin] + [coin]
          end
        end
      end
    end

    raise ImpossibleCombinationError, "impossible" if dp[target].nil?
    dp[target].sort
  end
end
