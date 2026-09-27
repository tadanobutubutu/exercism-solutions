import gleam/dict.{type Dict}
import gleam/int
import gleam/list
import gleam/string

pub type School {
  School(classes: Dict(Int, List(String)))
}

pub fn create() -> School {
  School(classes: dict.new())
}

pub fn roster(school: School) -> List(String) {
  school.classes
  |> dict.to_list
  |> list.sort(by: fn(left, right) { int.compare(left.0, right.0) })
  |> flatten_classes
}

pub fn add(
  to school: School,
  student student: String,
  grade grade: Int,
) -> Result(School, Nil) {
  case list.contains(roster(school), student) {
    True -> Error(Nil)
    False -> {
      let students = grade(school, grade)
      let updated_students = list.sort([student, ..students], by: string.compare)
      Ok(School(classes: dict.insert(school.classes, grade, updated_students)))
    }
  }
}

pub fn grade(school: School, desired_grade: Int) -> List(String) {
  case dict.get(school.classes, desired_grade) {
    Ok(students) -> list.sort(students, by: string.compare)
    Error(Nil) -> []
  }
}

fn flatten_classes(classes: List(#(Int, List(String)))) -> List(String) {
  case classes {
    [] -> []
    [#(_, students), ..rest] ->
      list.append(list.sort(students, by: string.compare), flatten_classes(rest))
  }
}
