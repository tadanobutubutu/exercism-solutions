import gleam/list
import gleam/string

pub type Student {
  Alice
  Bob
  Charlie
  David
  Eve
  Fred
  Ginny
  Harriet
  Ileana
  Joseph
  Kincaid
  Larry
}

pub type Plant {
  Radishes
  Clover
  Violets
  Grass
}

pub fn plants(diagram: String, student: Student) -> List(Plant) {
  let rows = string.split(diagram, on: "\n")
  let offset = student_index(student) * 2

  case rows {
    [first_row, second_row, ..] -> {
      let first_cups =
        first_row
        |> string.trim
        |> string.to_graphemes
        |> list.drop(offset)
        |> list.take(2)
      let second_cups =
        second_row
        |> string.trim
        |> string.to_graphemes
        |> list.drop(offset)
        |> list.take(2)
      list.append(to_plants(first_cups), to_plants(second_cups))
    }
    _ -> []
  }
}

fn student_index(student: Student) -> Int {
  case student {
    Alice -> 0
    Bob -> 1
    Charlie -> 2
    David -> 3
    Eve -> 4
    Fred -> 5
    Ginny -> 6
    Harriet -> 7
    Ileana -> 8
    Joseph -> 9
    Kincaid -> 10
    Larry -> 11
  }
}

fn to_plants(cups: List(String)) -> List(Plant) {
  list.map(cups, fn(cup) {
    case cup {
      "R" -> Radishes
      "C" -> Clover
      "V" -> Violets
      "G" -> Grass
      _ -> Grass
    }
  })
}
