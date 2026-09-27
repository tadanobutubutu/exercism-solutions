pub fn recite(start_verse start_verse: Int, end_verse end_verse: Int) -> String {
  recite_verses(start_verse, end_verse, "")
}

fn recite_verses(current: Int, end: Int, verses: String) -> String {
  case current > end {
    True -> verses
    False -> {
      let verse = "This is " <> body(current)
      let updated = append_line(verses, verse)
      recite_verses(current + 1, end, updated)
    }
  }
}

fn body(verse: Int) -> String {
  case verse {
    1 -> "the house that Jack built."
    2 -> "the malt that lay in " <> body(1)
    3 -> "the rat that ate " <> body(2)
    4 -> "the cat that killed " <> body(3)
    5 -> "the dog that worried " <> body(4)
    6 -> "the cow with the crumpled horn that tossed " <> body(5)
    7 -> "the maiden all forlorn that milked " <> body(6)
    8 -> "the man all tattered and torn that kissed " <> body(7)
    9 -> "the priest all shaven and shorn that married " <> body(8)
    10 -> "the rooster that crowed in the morn that woke " <> body(9)
    11 -> "the farmer sowing his corn that kept " <> body(10)
    12 -> "the horse and the hound and the horn that belonged to " <> body(11)
    _ -> ""
  }
}

fn append_line(existing: String, line: String) -> String {
  case existing {
    "" -> line
    _ -> existing <> "\n" <> line
  }
}
