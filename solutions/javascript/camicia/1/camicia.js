//
// This is only a SKELETON file for the 'Camicia' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const simulateGame = (playerA, playerB) => {
  const decks = [playerA.slice(), playerB.slice()];
  const totalCards = decks[0].length + decks[1].length;
  const payment = { J: 1, Q: 2, K: 3, A: 4 };
  const seen = new Set();
  let cardsPlayed = 0;
  let tricks = 0;
  let turn = 0;

  const signature = () =>
    `${decks[0].map((card) => (payment[card] ? card : 'N')).join('')}` +
    `|${decks[1].map((card) => (payment[card] ? card : 'N')).join('')}|${turn}`;

  const collect = (winner, pile) => {
    decks[winner].push(...pile);
    tricks += 1;
    turn = winner;
  };

  while (true) {
    if (decks[0].length === totalCards || decks[1].length === totalCards) {
      return { status: 'finished', cards: cardsPlayed, tricks };
    }

    const state = signature();
    if (seen.has(state)) return { status: 'loop', cards: cardsPlayed, tricks };
    seen.add(state);

    const pile = [];
    let current = turn;
    let roundCollected = false;

    while (!roundCollected) {
      if (decks[current].length === 0) {
        collect(1 - current, pile);
        roundCollected = true;
        continue;
      }

      const card = decks[current].shift();
      pile.push(card);
      cardsPlayed += 1;

      if (!payment[card]) {
        current = 1 - current;
        continue;
      }

      let penalty = payment[card];
      let payer = 1 - current;
      let lastPaymentPlayer = current;
      while (!roundCollected) {
        if (decks[payer].length === 0) {
          collect(lastPaymentPlayer, pile);
          roundCollected = true;
          break;
        }

        const paidCard = decks[payer].shift();
        pile.push(paidCard);
        cardsPlayed += 1;
        if (payment[paidCard]) {
          penalty = payment[paidCard];
          lastPaymentPlayer = payer;
          payer = 1 - payer;
        } else {
          penalty -= 1;
          if (penalty === 0) {
            collect(lastPaymentPlayer, pile);
            roundCollected = true;
          }
        }
      }
    }
  }
};
