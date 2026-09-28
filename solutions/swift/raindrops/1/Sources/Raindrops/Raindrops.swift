func raindrops(_ number: Int) -> String {
  var sounds: [String] = []
  if number.isMultiple(of: 3) { sounds.append("Pling") }
  if number.isMultiple(of: 5) { sounds.append("Plang") }
  if number.isMultiple(of: 7) { sounds.append("Plong") }
  return sounds.isEmpty ? String(number) : sounds.joined()
}
