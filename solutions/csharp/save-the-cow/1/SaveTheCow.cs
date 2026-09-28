using System.Collections.Immutable;
using System.Reactive;
using System.Reactive.Subjects;

public class GameState
{
    public string MaskedWord { get; }
    public ImmutableHashSet<char> GuessedChars { get; }
    public int RemainingGuesses { get; }

    public GameState(string maskedWord, ImmutableHashSet<char> guessedChars, int remainingGuesses)
    {
        MaskedWord = maskedWord;
        GuessedChars = guessedChars;
        RemainingGuesses = remainingGuesses;
    }
}

public class TooManyGuessesException : Exception
{
}

public class SaveTheCow
{
    public IObservable<GameState> StateObservable { get; }
    public IObserver<char> GuessObserver { get; }
  
    public SaveTheCow(string word)
    {
        ArgumentNullException.ThrowIfNull(word);

        const int initialGuesses = 9;
        var initialGuessedChars = ImmutableHashSet<char>.Empty;
        var state = new BehaviorSubject<GameState>(new GameState(
            MaskWord(word, initialGuessedChars), initialGuessedChars, initialGuesses));
        StateObservable = state;

        bool finished = false;
        GuessObserver = Observer.Create<char>(letter =>
        {
            if (finished)
            {
                return;
            }

            GameState current = state.Value;
            bool isNewCorrectGuess = !current.GuessedChars.Contains(letter) && word.Contains(letter);
            ImmutableHashSet<char> guessedChars = current.GuessedChars.Add(letter);
            string maskedWord = MaskWord(word, guessedChars);

            if (maskedWord == word)
            {
                finished = true;
                state.OnCompleted();
                return;
            }

            if (current.RemainingGuesses == 0)
            {
                finished = true;
                state.OnError(new TooManyGuessesException());
                return;
            }

            int remainingGuesses = current.RemainingGuesses - (isNewCorrectGuess ? 0 : 1);
            state.OnNext(new GameState(maskedWord, guessedChars, remainingGuesses));
        });
    }

    private static string MaskWord(string word, ImmutableHashSet<char> guessedChars) =>
        string.Concat(word.Select(letter => guessedChars.Contains(letter) ? letter : '_'));
}
