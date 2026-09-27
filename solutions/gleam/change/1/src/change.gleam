import gleam/int
import gleam/list

pub type Error {
  ImpossibleTarget
}

pub fn find_fewest_coins(
  coins: List(Int),
  target: Int,
) -> Result(List(Int), Error) {
  case target < 0 {
    True -> Error(ImpossibleTarget)
    False -> {
      let solutions = build_solutions(1, target, coins, [Some([])])
      case get_solution(solutions, target) {
        Some(solution) -> Ok(solution)
        None -> Error(ImpossibleTarget)
      }
    }
  }
}

fn build_solutions(
  amount: Int,
  target: Int,
  coins: List(Int),
  solutions: List(Option(List(Int))),
) -> List(Option(List(Int))) {
  case amount > target {
    True -> solutions
    False -> {
      let best = best_for_amount(coins, amount, solutions, None)
      build_solutions(amount + 1, target, coins, list.append(solutions, [best]))
    }
  }
}

fn best_for_amount(
  coins: List(Int),
  amount: Int,
  solutions: List(Option(List(Int))),
  best: Option(List(Int)),
) -> Option(List(Int)) {
  case coins {
    [] -> best
    [coin, ..rest] ->
      case coin > 0 && coin <= amount {
        False -> best_for_amount(rest, amount, solutions, best)
        True ->
          case get_solution(solutions, amount - coin) {
            None -> best_for_amount(rest, amount, solutions, best)
            Some(solution) -> {
              let candidate = list.sort([coin, ..solution], by: int.compare)
              best_for_amount(rest, amount, solutions, choose_better(best, candidate))
            }
          }
      }
  }
}

fn choose_better(current: Option(List(Int)), candidate: List(Int)) -> Option(List(Int)) {
  case current {
    None -> Some(candidate)
    Some(existing) ->
      case list.length(candidate) < list.length(existing) {
        True -> Some(candidate)
        False -> current
      }
  }
}

fn get_solution(solutions: List(Option(List(Int))), index: Int) -> Option(List(Int)) {
  case list.drop(solutions, index) {
    [solution, .._] -> solution
    [] -> None
  }
}
