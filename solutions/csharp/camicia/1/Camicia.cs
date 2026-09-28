public static class Camicia
{
    public enum GameStatus
    {
        Finished,
        Loop
    }

    public record GameResult(GameStatus Status, int Tricks, int Cards);

    public static GameResult SimulateGame(string[] playerA, string[] playerB)
    {
        ArgumentNullException.ThrowIfNull(playerA);
        ArgumentNullException.ThrowIfNull(playerB);

        var decks = new[] { new Queue<string>(playerA), new Queue<string>(playerB) };
        int totalCards = playerA.Length + playerB.Length;
        var pile = new List<string>();
        var seenDecks = new HashSet<string>(StringComparer.Ordinal);
        int tricks = 0;
        int cardsPlayed = 0;
        int currentPlayer = 0;

        while (true)
        {
            if (!seenDecks.Add(DeckSignature(decks)))
                return new GameResult(GameStatus.Loop, tricks, cardsPlayed);

            int penaltyDue = 0;
            int lastPaymentPlayer = -1;
            bool trickFinished = false;

            while (!trickFinished)
            {
                Queue<string> currentDeck = decks[currentPlayer];
                if (currentDeck.Count == 0)
                {
                    int collector = 1 - currentPlayer;
                    Collect(decks[collector], pile);
                    tricks++;
                    if (decks[collector].Count == totalCards)
                        return new GameResult(GameStatus.Finished, tricks, cardsPlayed);
                    currentPlayer = collector;
                    trickFinished = true;
                    continue;
                }

                string card = currentDeck.Dequeue();
                pile.Add(card);
                cardsPlayed++;
                int newPenalty = Penalty(card);

                if (penaltyDue == 0)
                {
                    if (newPenalty > 0)
                    {
                        penaltyDue = newPenalty;
                        lastPaymentPlayer = currentPlayer;
                    }
                    currentPlayer = 1 - currentPlayer;
                    continue;
                }

                if (newPenalty > 0)
                {
                    penaltyDue = newPenalty;
                    lastPaymentPlayer = currentPlayer;
                    currentPlayer = 1 - currentPlayer;
                    continue;
                }

                penaltyDue--;
                if (penaltyDue == 0)
                {
                    Collect(decks[lastPaymentPlayer], pile);
                    tricks++;
                    if (decks[lastPaymentPlayer].Count == totalCards)
                        return new GameResult(GameStatus.Finished, tricks, cardsPlayed);
                    currentPlayer = lastPaymentPlayer;
                    trickFinished = true;
                }
            }
        }
    }

    private static int Penalty(string card) => card switch
    {
        "J" => 1,
        "Q" => 2,
        "K" => 3,
        "A" => 4,
        _ => 0
    };

    private static void Collect(Queue<string> deck, List<string> pile)
    {
        foreach (string card in pile) deck.Enqueue(card);
        pile.Clear();
    }

    private static string DeckSignature(Queue<string>[] decks)
    {
        static string Normalize(string card) => Penalty(card) > 0 ? card : "N";
        return string.Join(',', decks[0].Select(Normalize)) + "|" + string.Join(',', decks[1].Select(Normalize));
    }
}
