export function commands(code: number): string[] {
  const actions = ['wink', 'double blink', 'close your eyes', 'jump']
  const handshake: string[] = []

  for (let bit = 0; bit < actions.length; bit += 1) {
    if ((code & (1 << bit)) !== 0) handshake.push(actions[bit])
  }

  if ((code & 16) !== 0) handshake.reverse()
  return handshake
}
