import gleam/int
import gleam/list
import gleam/order.{type Order, Eq}
import gleam/string

type Team {
  Team(name: String, played: Int, wins: Int, draws: Int, losses: Int, points: Int)
}

pub fn tally(input: String) -> String {
  let teams = process_matches(string.split(input, on: "\n"), [])
  let sorted = list.sort(teams, by: compare_teams)
  render(sorted, "Team                           | MP |  W |  D |  L |  P")
}

fn process_matches(lines: List(String), teams: List(Team)) -> List(Team) {
  case lines {
    [] -> teams
    [line, ..rest] ->
      case string.split(line, on: ";") {
        [team_a, team_b, result] -> {
          let updated =
            case result {
              "win" ->
                teams
                |> update_team(team_a, 1, 0, 0, 3)
                |> update_team(team_b, 0, 0, 1, 0)
              "loss" ->
                teams
                |> update_team(team_a, 0, 0, 1, 0)
                |> update_team(team_b, 1, 0, 0, 3)
              "draw" ->
                teams
                |> update_team(team_a, 0, 1, 0, 1)
                |> update_team(team_b, 0, 1, 0, 1)
              _ -> teams
            }
          process_matches(rest, updated)
        }
        _ -> process_matches(rest, teams)
      }
  }
}

fn update_team(
  teams: List(Team),
  name: String,
  wins: Int,
  draws: Int,
  losses: Int,
  points: Int,
) -> List(Team) {
  case teams {
    [] -> [Team(name: name, played: 1, wins: wins, draws: draws, losses: losses, points: points)]
    [Team(name: existing, played: played, wins: old_wins, draws: old_draws, losses: old_losses, points: old_points), ..rest]
    if existing == name ->
      [
        Team(
          name: name,
          played: played + 1,
          wins: old_wins + wins,
          draws: old_draws + draws,
          losses: old_losses + losses,
          points: old_points + points,
        ),
        ..rest
      ]
    [team, ..rest] -> [team, ..update_team(rest, name, wins, draws, losses, points)]
  }
}

fn compare_teams(left: Team, right: Team) -> Order {
  case int.compare(left.points, right.points) {
    Eq -> string.compare(left.name, right.name)
    _ -> int.compare(right.points, left.points)
  }
}

fn render(teams: List(Team), result: String) -> String {
  case teams {
    [] -> result
    [Team(name: name, played: played, wins: wins, draws: draws, losses: losses, points: points), ..rest] ->
      render(
        rest,
        result
        <> "\n"
        <> pad_name(name)
        <> "| "
        <> two_digits(played)
        <> " | "
        <> two_digits(wins)
        <> " | "
        <> two_digits(draws)
        <> " | "
        <> two_digits(losses)
        <> " | "
        <> two_digits(points),
      )
  }
}

fn pad_name(name: String) -> String {
  name <> repeat_spaces(31 - string.length(name), "")
}

fn repeat_spaces(count: Int, result: String) -> String {
  case count <= 0 {
    True -> result
    False -> repeat_spaces(count - 1, result <> " ")
  }
}

fn two_digits(number: Int) -> String {
  case number < 10 {
    True -> " " <> int.to_string(number)
    False -> int.to_string(number)
  }
}
